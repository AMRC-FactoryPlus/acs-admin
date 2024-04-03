import { defineConfig } from 'vite';
import preact from '@preact/preset-vite';
import ignore from "rollup-plugin-ignore";
import builtins from 'rollup-plugin-node-builtins';
import globals from 'rollup-plugin-node-globals';

// https://vitejs.dev/config/
export default defineConfig({
    build: {
        target: "esnext",
    },
    optimizeDeps: {
        esbuildOptions: {
            target: "esnext",
        },
        exclude: [
            "rxjs",
            "@amrc-factoryplus/sparkplug-app",
        ],
    },
    plugins: [
        preact(),
        ignore([
            "gssapi.js",
            "rxjs",
            "@amrc-factoryplus/sparkplug-app",
        ]),
        globals(),
        builtins(),
    ],
});
