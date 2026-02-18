#!/usr/bin/env node
/**
 * Validate Cursor rules consistency.
 * Checks:
 * 1) Forbidden legacy typos (sepcs/)
 * 2) Legacy report placeholder style (YYYY-MM-DD.report.json)
 * 3) Broken references to local .mdc files in backticks
 */

const fs = require("fs");
const path = require("path");

const root = process.cwd();
const rulesDir = path.join(root, ".cursor", "rules");

if (!fs.existsSync(rulesDir)) {
  console.error("❌ Pasta de regras nao encontrada: .cursor/rules");
  process.exit(1);
}

function listRuleFiles(dir) {
  return fs
    .readdirSync(dir, { withFileTypes: true })
    .filter(entry => entry.isFile() && entry.name.endsWith(".mdc"))
    .map(entry => path.join(dir, entry.name));
}

function read(filePath) {
  return fs.readFileSync(filePath, "utf8");
}

const files = listRuleFiles(rulesDir);
const fileSet = new Set(files.map(f => path.basename(f)));
const problems = [];

for (const file of files) {
  const rel = path.relative(root, file).replace(/\\/g, "/");
  const content = read(file);

  if (content.includes("sepcs/")) {
    problems.push(`${rel}: referencia legada "sepcs/" encontrada`);
  }

  if (content.includes("reports/YYYY-MM-DD.report.json")) {
    problems.push(`${rel}: placeholder antigo "reports/YYYY-MM-DD.report.json" encontrado`);
  }

  const matches = content.match(/`([^`]+\.mdc)`/g) || [];
  for (const raw of matches) {
    const ref = raw.slice(1, -1);
    if (ref.includes("/")) continue;
    if (!fileSet.has(ref)) {
      problems.push(`${rel}: referencia de regra inexistente: ${ref}`);
    }
  }
}

if (problems.length > 0) {
  console.error("❌ Validacao de regras falhou:");
  for (const p of problems) {
    console.error(`- ${p}`);
  }
  process.exit(1);
}

console.log("✅ Validacao de regras passou.");
