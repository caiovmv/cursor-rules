#!/usr/bin/env node
/**
 * Script para remover a pasta de exemplos do projeto.
 * Execute quando o projeto estiver pronto para entrega.
 * 
 * Uso: node scripts/remove-examples.js
 */

const fs = require("fs");
const path = require("path");

const examplesDir = path.join(process.cwd(), "examples");

if (!fs.existsSync(examplesDir)) {
  console.log("Pasta examples/ nao encontrada.");
  console.log("O projeto ja esta pronto para entrega.");
  process.exit(0);
}

try {
  fs.rmSync(examplesDir, { recursive: true, force: true });
  console.log("✅ Pasta examples/ removida com sucesso.");
  console.log("   Projeto pronto para entrega.");
} catch (error) {
  console.error("❌ Erro ao remover pasta examples/:");
  console.error(error.message);
  process.exit(1);
}
