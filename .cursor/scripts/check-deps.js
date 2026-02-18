#!/usr/bin/env node
/**
 * Dependency Version Checker
 * 
 * Verifica dependencias desatualizadas e sugere atualizacoes seguras
 * mantendo a mesma MAJOR version (SemVer).
 * 
 * Uso: node scripts/check-deps.js [--update] [--json]
 * 
 * Opcoes:
 *   --update  Gera comandos npm install para atualizacoes seguras
 *   --json    Saida em formato JSON
 */

const { execSync } = require("child_process");
const fs = require("fs");
const path = require("path");

const args = process.argv.slice(2);
const generateUpdate = args.includes("--update");
const jsonOutput = args.includes("--json");

// Carregar package.json
const packagePath = path.join(process.cwd(), "package.json");
if (!fs.existsSync(packagePath)) {
  console.error("Erro: package.json nao encontrado");
  process.exit(1);
}

const pkg = JSON.parse(fs.readFileSync(packagePath, "utf-8"));
const allDeps = {
  ...pkg.dependencies,
  ...pkg.devDependencies
};

// Obter dependencias desatualizadas
let outdatedData;
try {
  const output = execSync("npm outdated --json 2>/dev/null || true", {
    encoding: "utf-8",
    maxBuffer: 10 * 1024 * 1024
  });
  outdatedData = output.trim() ? JSON.parse(output) : {};
} catch (err) {
  outdatedData = {};
}

// Analisar cada dependencia
const safeUpdates = [];
const blockedUpdates = [];
const upToDate = [];

function parseSemver(version) {
  if (!version) return null;
  const clean = version.replace(/^[\^~>=<]*/g, "");
  const parts = clean.split(".");
  return {
    major: parseInt(parts[0]) || 0,
    minor: parseInt(parts[1]) || 0,
    patch: parseInt(parts[2]) || 0,
    full: clean
  };
}

for (const [name, info] of Object.entries(outdatedData)) {
  const current = parseSemver(info.current);
  const wanted = parseSemver(info.wanted);
  const latest = parseSemver(info.latest);
  
  if (!current || !latest) continue;
  
  // Verificar se latest tem mesma MAJOR
  if (latest.major === current.major) {
    // Atualizacao segura
    if (latest.full !== current.full) {
      safeUpdates.push({
        name,
        current: current.full,
        available: latest.full,
        type: "safe"
      });
    }
  } else {
    // Atualizacao bloqueada (MAJOR diferente)
    // Buscar ultima versao da mesma MAJOR
    let safestVersion = wanted ? wanted.full : current.full;
    
    if (wanted && wanted.major === current.major && wanted.full !== current.full) {
      safeUpdates.push({
        name,
        current: current.full,
        available: wanted.full,
        type: "safe",
        note: `Latest ${latest.full} bloqueado (major change)`
      });
    }
    
    blockedUpdates.push({
      name,
      current: current.full,
      available: latest.full,
      reason: `Major version change (${current.major} -> ${latest.major})`
    });
  }
}

// Contar dependencias atualizadas
const outdatedNames = Object.keys(outdatedData);
const totalDeps = Object.keys(allDeps).length;
const upToDateCount = totalDeps - outdatedNames.length;

// Gerar saida
if (jsonOutput) {
  console.log(JSON.stringify({
    date: new Date().toISOString().split("T")[0],
    total: totalDeps,
    upToDate: upToDateCount,
    safeUpdates,
    blockedUpdates
  }, null, 2));
} else {
  console.log("");
  console.log("=".repeat(60));
  console.log(" RELATORIO DE DEPENDENCIAS");
  console.log("=".repeat(60));
  console.log("");
  console.log(`Data: ${new Date().toISOString().split("T")[0]}`);
  console.log(`Total de dependencias: ${totalDeps}`);
  console.log(`Atualizadas: ${upToDateCount}`);
  console.log(`Desatualizadas: ${outdatedNames.length}`);
  console.log("");
  
  if (safeUpdates.length > 0) {
    console.log("-".repeat(60));
    console.log(" ATUALIZACOES SEGURAS (mesma MAJOR)");
    console.log("-".repeat(60));
    console.log("");
    console.log("| Pacote | Atual | Disponivel |");
    console.log("|--------|-------|------------|");
    safeUpdates.forEach(u => {
      console.log(`| ${u.name} | ${u.current} | ${u.available} |`);
    });
    console.log("");
  }
  
  if (blockedUpdates.length > 0) {
    console.log("-".repeat(60));
    console.log(" ATUALIZACOES BLOQUEADAS (MAJOR diferente)");
    console.log("-".repeat(60));
    console.log("");
    console.log("| Pacote | Atual | Disponivel | Motivo |");
    console.log("|--------|-------|------------|--------|");
    blockedUpdates.forEach(u => {
      console.log(`| ${u.name} | ${u.current} | ${u.available} | ${u.reason} |`);
    });
    console.log("");
  }
  
  if (generateUpdate && safeUpdates.length > 0) {
    console.log("-".repeat(60));
    console.log(" COMANDOS DE ATUALIZACAO");
    console.log("-".repeat(60));
    console.log("");
    safeUpdates.forEach(u => {
      console.log(`npm install ${u.name}@${u.available}`);
    });
    console.log("");
    console.log("# Ou todos de uma vez:");
    const allUpdates = safeUpdates.map(u => `${u.name}@${u.available}`).join(" ");
    console.log(`npm install ${allUpdates}`);
    console.log("");
  }
  
  if (safeUpdates.length === 0 && blockedUpdates.length === 0) {
    console.log("Todas as dependencias estao atualizadas!");
    console.log("");
  }
  
  console.log("=".repeat(60));
}

// Exit code
if (safeUpdates.length > 0) {
  process.exit(0); // Tem atualizacoes disponiveis
} else {
  process.exit(0); // Tudo atualizado
}
