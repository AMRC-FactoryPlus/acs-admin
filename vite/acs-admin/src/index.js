/*
 * ACS Advanced Admin interface
 * Top-level UI
 * Copyright 2024 AMRC
 */

import { h, render, createContext }                 from "preact";
import { useContext, useEffect, useRef, useState }  from "preact/hooks";
import { signal, useSignal }                        from "@preact/signals";
import { LocationProvider, Router, Route }          from 'preact-iso';

import htm          from "htm";

import { ServiceClient, UUIDs }     from "@amrc-factoryplus/service-client";

const html = htm.bind(h);

function App () {
    return html`
        <h1>ACS Advanced Admin interface</h1>
    `;
}

render(html`<${App}/>`, document.getElementById("app"));
