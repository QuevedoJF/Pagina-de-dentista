/// <reference path="../.astro/types.d.ts" />
/// <reference types="astro/client" />

interface ImportMetaEnv {
  readonly PG_HOST: string;
  readonly PG_PORT: string;
  readonly PG_DATABASE: string;
  readonly PG_USER: string;
  readonly PG_PASSWORD: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}

declare namespace App {
  interface Locals {
    config: Record<string, string>;
  }
}