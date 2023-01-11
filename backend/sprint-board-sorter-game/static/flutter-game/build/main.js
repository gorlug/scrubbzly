/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ 163:
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "__assign": () => (/* binding */ __assign),
/* harmony export */   "__asyncDelegator": () => (/* binding */ __asyncDelegator),
/* harmony export */   "__asyncGenerator": () => (/* binding */ __asyncGenerator),
/* harmony export */   "__asyncValues": () => (/* binding */ __asyncValues),
/* harmony export */   "__await": () => (/* binding */ __await),
/* harmony export */   "__awaiter": () => (/* binding */ __awaiter),
/* harmony export */   "__classPrivateFieldGet": () => (/* binding */ __classPrivateFieldGet),
/* harmony export */   "__classPrivateFieldSet": () => (/* binding */ __classPrivateFieldSet),
/* harmony export */   "__createBinding": () => (/* binding */ __createBinding),
/* harmony export */   "__decorate": () => (/* binding */ __decorate),
/* harmony export */   "__exportStar": () => (/* binding */ __exportStar),
/* harmony export */   "__extends": () => (/* binding */ __extends),
/* harmony export */   "__generator": () => (/* binding */ __generator),
/* harmony export */   "__importDefault": () => (/* binding */ __importDefault),
/* harmony export */   "__importStar": () => (/* binding */ __importStar),
/* harmony export */   "__makeTemplateObject": () => (/* binding */ __makeTemplateObject),
/* harmony export */   "__metadata": () => (/* binding */ __metadata),
/* harmony export */   "__param": () => (/* binding */ __param),
/* harmony export */   "__read": () => (/* binding */ __read),
/* harmony export */   "__rest": () => (/* binding */ __rest),
/* harmony export */   "__spread": () => (/* binding */ __spread),
/* harmony export */   "__spreadArrays": () => (/* binding */ __spreadArrays),
/* harmony export */   "__values": () => (/* binding */ __values)
/* harmony export */ });
/*! *****************************************************************************
Copyright (c) Microsoft Corporation.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
***************************************************************************** */
/* global Reflect, Promise */

var extendStatics = function(d, b) {
    extendStatics = Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
        function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
    return extendStatics(d, b);
};

function __extends(d, b) {
    extendStatics(d, b);
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
}

var __assign = function() {
    __assign = Object.assign || function __assign(t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p)) t[p] = s[p];
        }
        return t;
    }
    return __assign.apply(this, arguments);
}

function __rest(s, e) {
    var t = {};
    for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
        t[p] = s[p];
    if (s != null && typeof Object.getOwnPropertySymbols === "function")
        for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
            if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                t[p[i]] = s[p[i]];
        }
    return t;
}

function __decorate(decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
}

function __param(paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
}

function __metadata(metadataKey, metadataValue) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(metadataKey, metadataValue);
}

function __awaiter(thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
}

function __generator(thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
}

function __createBinding(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}

function __exportStar(m, exports) {
    for (var p in m) if (p !== "default" && !exports.hasOwnProperty(p)) exports[p] = m[p];
}

function __values(o) {
    var s = typeof Symbol === "function" && Symbol.iterator, m = s && o[s], i = 0;
    if (m) return m.call(o);
    if (o && typeof o.length === "number") return {
        next: function () {
            if (o && i >= o.length) o = void 0;
            return { value: o && o[i++], done: !o };
        }
    };
    throw new TypeError(s ? "Object is not iterable." : "Symbol.iterator is not defined.");
}

function __read(o, n) {
    var m = typeof Symbol === "function" && o[Symbol.iterator];
    if (!m) return o;
    var i = m.call(o), r, ar = [], e;
    try {
        while ((n === void 0 || n-- > 0) && !(r = i.next()).done) ar.push(r.value);
    }
    catch (error) { e = { error: error }; }
    finally {
        try {
            if (r && !r.done && (m = i["return"])) m.call(i);
        }
        finally { if (e) throw e.error; }
    }
    return ar;
}

function __spread() {
    for (var ar = [], i = 0; i < arguments.length; i++)
        ar = ar.concat(__read(arguments[i]));
    return ar;
}

function __spreadArrays() {
    for (var s = 0, i = 0, il = arguments.length; i < il; i++) s += arguments[i].length;
    for (var r = Array(s), k = 0, i = 0; i < il; i++)
        for (var a = arguments[i], j = 0, jl = a.length; j < jl; j++, k++)
            r[k] = a[j];
    return r;
};

function __await(v) {
    return this instanceof __await ? (this.v = v, this) : new __await(v);
}

function __asyncGenerator(thisArg, _arguments, generator) {
    if (!Symbol.asyncIterator) throw new TypeError("Symbol.asyncIterator is not defined.");
    var g = generator.apply(thisArg, _arguments || []), i, q = [];
    return i = {}, verb("next"), verb("throw"), verb("return"), i[Symbol.asyncIterator] = function () { return this; }, i;
    function verb(n) { if (g[n]) i[n] = function (v) { return new Promise(function (a, b) { q.push([n, v, a, b]) > 1 || resume(n, v); }); }; }
    function resume(n, v) { try { step(g[n](v)); } catch (e) { settle(q[0][3], e); } }
    function step(r) { r.value instanceof __await ? Promise.resolve(r.value.v).then(fulfill, reject) : settle(q[0][2], r); }
    function fulfill(value) { resume("next", value); }
    function reject(value) { resume("throw", value); }
    function settle(f, v) { if (f(v), q.shift(), q.length) resume(q[0][0], q[0][1]); }
}

function __asyncDelegator(o) {
    var i, p;
    return i = {}, verb("next"), verb("throw", function (e) { throw e; }), verb("return"), i[Symbol.iterator] = function () { return this; }, i;
    function verb(n, f) { i[n] = o[n] ? function (v) { return (p = !p) ? { value: __await(o[n](v)), done: n === "return" } : f ? f(v) : v; } : f; }
}

function __asyncValues(o) {
    if (!Symbol.asyncIterator) throw new TypeError("Symbol.asyncIterator is not defined.");
    var m = o[Symbol.asyncIterator], i;
    return m ? m.call(o) : (o = typeof __values === "function" ? __values(o) : o[Symbol.iterator](), i = {}, verb("next"), verb("throw"), verb("return"), i[Symbol.asyncIterator] = function () { return this; }, i);
    function verb(n) { i[n] = o[n] && function (v) { return new Promise(function (resolve, reject) { v = o[n](v), settle(resolve, reject, v.done, v.value); }); }; }
    function settle(resolve, reject, d, v) { Promise.resolve(v).then(function(v) { resolve({ value: v, done: d }); }, reject); }
}

function __makeTemplateObject(cooked, raw) {
    if (Object.defineProperty) { Object.defineProperty(cooked, "raw", { value: raw }); } else { cooked.raw = raw; }
    return cooked;
};

function __importStar(mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (Object.hasOwnProperty.call(mod, k)) result[k] = mod[k];
    result.default = mod;
    return result;
}

function __importDefault(mod) {
    return (mod && mod.__esModule) ? mod : { default: mod };
}

function __classPrivateFieldGet(receiver, privateMap) {
    if (!privateMap.has(receiver)) {
        throw new TypeError("attempted to get private field on non-instance");
    }
    return privateMap.get(receiver);
}

function __classPrivateFieldSet(receiver, privateMap, value) {
    if (!privateMap.has(receiver)) {
        throw new TypeError("attempted to set private field on non-instance");
    }
    privateMap.set(receiver, value);
    return value;
}


/***/ }),

/***/ 999:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.getCallBridge = void 0;
const errors_1 = __webpack_require__(712);
function isBridgeAvailable(bridge) {
    return !!(bridge === null || bridge === void 0 ? void 0 : bridge.callBridge);
}
const getCallBridge = () => {
    if (!isBridgeAvailable(window.__bridge)) {
        throw new errors_1.BridgeAPIError(`
      Unable to establish a connection with the Custom UI bridge.
      If you are trying to run your app locally, Forge apps only work in the context of Atlassian products. Refer to https://go.atlassian.com/forge-tunneling-with-custom-ui for how to tunnel when using a local development server.
    `);
    }
    return window.__bridge.callBridge;
};
exports.getCallBridge = getCallBridge;


/***/ }),

/***/ 712:
/***/ ((__unused_webpack_module, exports) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.BridgeAPIError = void 0;
class BridgeAPIError extends Error {
}
exports.BridgeAPIError = BridgeAPIError;


/***/ }),

/***/ 634:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.events = void 0;
const bridge_1 = __webpack_require__(999);
const callBridge = (0, bridge_1.getCallBridge)();
const emit = (event, payload) => {
    return callBridge('emit', { event, payload });
};
const on = (event, callback) => {
    return callBridge('on', { event, callback });
};
exports.events = {
    emit,
    on
};


/***/ }),

/***/ 568:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
const tslib_1 = __webpack_require__(163);
tslib_1.__exportStar(__webpack_require__(634), exports);


/***/ }),

/***/ 701:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.productFetchApi = void 0;
const tslib_1 = __webpack_require__(163);
const parseBodyAndHeaders = (init) => tslib_1.__awaiter(void 0, void 0, void 0, function* () {
    const req = new Request('', { body: init === null || init === void 0 ? void 0 : init.body, method: init === null || init === void 0 ? void 0 : init.method, headers: init === null || init === void 0 ? void 0 : init.headers });
    const body = req.method !== 'GET' ? yield req.text() : null;
    const headers = Object.fromEntries(req.headers.entries());
    return {
        body,
        headers: new Headers(headers)
    };
});
const productFetchApi = (callBridge) => {
    const fetch = (product, restPath, init) => tslib_1.__awaiter(void 0, void 0, void 0, function* () {
        const { body: requestBody, headers: requestHeaders } = yield parseBodyAndHeaders(init);
        if (!requestHeaders.has('X-Atlassian-Token')) {
            requestHeaders.set('X-Atlassian-Token', 'no-check');
        }
        const fetchPayload = {
            product,
            restPath,
            fetchRequestInit: Object.assign(Object.assign({}, init), { body: requestBody, headers: [...requestHeaders.entries()] })
        };
        const { body, headers, statusText, status } = yield callBridge('fetchProduct', fetchPayload);
        return new Response(body || null, { headers, status, statusText });
    });
    return {
        requestConfluence: (restPath, fetchOptions) => fetch('confluence', restPath, fetchOptions),
        requestJira: (restPath, fetchOptions) => fetch('jira', restPath, fetchOptions)
    };
};
exports.productFetchApi = productFetchApi;


/***/ }),

/***/ 62:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


var _a;
Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.requestJira = exports.requestConfluence = void 0;
const bridge_1 = __webpack_require__(999);
const fetch_1 = __webpack_require__(701);
_a = (0, fetch_1.productFetchApi)((0, bridge_1.getCallBridge)()), exports.requestConfluence = _a.requestConfluence, exports.requestJira = _a.requestJira;


/***/ }),

/***/ 726:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.showFlag = void 0;
const tslib_1 = __webpack_require__(163);
const bridge_1 = __webpack_require__(999);
const errors_1 = __webpack_require__(712);
const callBridge = (0, bridge_1.getCallBridge)();
const showFlag = (options) => {
    var _a;
    if (!options.id) {
        throw new errors_1.BridgeAPIError('"id" must be defined in flag options');
    }
    const result = callBridge('showFlag', Object.assign(Object.assign({}, options), { type: (_a = options.type) !== null && _a !== void 0 ? _a : 'info' }));
    return {
        close: () => tslib_1.__awaiter(void 0, void 0, void 0, function* () {
            yield result;
            return callBridge('closeFlag', { id: options.id });
        })
    };
};
exports.showFlag = showFlag;


/***/ }),

/***/ 320:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.showFlag = void 0;
var flag_1 = __webpack_require__(726);
Object.defineProperty(exports, "showFlag", ({ enumerable: true, get: function () { return flag_1.showFlag; } }));


/***/ }),

/***/ 788:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
const tslib_1 = __webpack_require__(163);
tslib_1.__exportStar(__webpack_require__(908), exports);
tslib_1.__exportStar(__webpack_require__(837), exports);
tslib_1.__exportStar(__webpack_require__(718), exports);
tslib_1.__exportStar(__webpack_require__(249), exports);
tslib_1.__exportStar(__webpack_require__(62), exports);
tslib_1.__exportStar(__webpack_require__(320), exports);
tslib_1.__exportStar(__webpack_require__(568), exports);


/***/ }),

/***/ 908:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
const tslib_1 = __webpack_require__(163);
tslib_1.__exportStar(__webpack_require__(389), exports);


/***/ }),

/***/ 389:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.invoke = void 0;
const bridge_1 = __webpack_require__(999);
const errors_1 = __webpack_require__(712);
const utils_1 = __webpack_require__(724);
const callBridge = (0, bridge_1.getCallBridge)();
const validatePayload = (payload) => {
    if (!payload)
        return;
    if (Object.values(payload).some((val) => typeof val === 'function')) {
        throw new errors_1.BridgeAPIError('Passing functions as part of the payload is not supported!');
    }
};
const _invoke = (functionKey, payload) => {
    if (typeof functionKey !== 'string') {
        throw new errors_1.BridgeAPIError('functionKey must be a string!');
    }
    validatePayload(payload);
    return callBridge('invoke', { functionKey, payload });
};
exports.invoke = (0, utils_1.withRateLimiter)(_invoke, 20, 2000, 'Resolver calls are rate limited at 20req/2s');


/***/ }),

/***/ 249:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
const tslib_1 = __webpack_require__(163);
tslib_1.__exportStar(__webpack_require__(676), exports);


/***/ }),

/***/ 676:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.Modal = void 0;
const tslib_1 = __webpack_require__(163);
const bridge_1 = __webpack_require__(999);
const errors_1 = __webpack_require__(712);
const callBridge = (0, bridge_1.getCallBridge)();
const noop = () => { };
class Modal {
    constructor(opts) {
        var _a, _b;
        this.resource = (opts === null || opts === void 0 ? void 0 : opts.resource) || null;
        this.onClose = (opts === null || opts === void 0 ? void 0 : opts.onClose) || noop;
        this.size = (opts === null || opts === void 0 ? void 0 : opts.size) || 'medium';
        this.context = (opts === null || opts === void 0 ? void 0 : opts.context) || {};
        this.closeOnEscape = (_a = opts === null || opts === void 0 ? void 0 : opts.closeOnEscape) !== null && _a !== void 0 ? _a : true;
        this.closeOnOverlayClick = (_b = opts === null || opts === void 0 ? void 0 : opts.closeOnOverlayClick) !== null && _b !== void 0 ? _b : true;
    }
    open() {
        return tslib_1.__awaiter(this, void 0, void 0, function* () {
            try {
                const success = yield callBridge('openModal', {
                    resource: this.resource,
                    onClose: this.onClose,
                    size: this.size,
                    context: this.context,
                    closeOnEscape: this.closeOnEscape,
                    closeOnOverlayClick: this.closeOnOverlayClick
                });
                if (success === false) {
                    throw new errors_1.BridgeAPIError('Unable to open modal.');
                }
            }
            catch (err) {
                throw new errors_1.BridgeAPIError('Unable to open modal.');
            }
        });
    }
}
exports.Modal = Modal;


/***/ }),

/***/ 718:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
const tslib_1 = __webpack_require__(163);
tslib_1.__exportStar(__webpack_require__(219), exports);


/***/ }),

/***/ 219:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.router = void 0;
const tslib_1 = __webpack_require__(163);
const bridge_1 = __webpack_require__(999);
const callBridge = (0, bridge_1.getCallBridge)();
const navigate = (url) => tslib_1.__awaiter(void 0, void 0, void 0, function* () { return callBridge('navigate', { url, type: 'same-tab' }); });
const open = (url) => tslib_1.__awaiter(void 0, void 0, void 0, function* () { return callBridge('navigate', { url, type: 'new-tab' }); });
const reload = () => tslib_1.__awaiter(void 0, void 0, void 0, function* () { return callBridge('reload'); });
exports.router = {
    navigate,
    open,
    reload
};


/***/ }),

/***/ 724:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.withRateLimiter = void 0;
const tslib_1 = __webpack_require__(163);
const errors_1 = __webpack_require__(712);
const withRateLimiter = (wrappedFn, maxOps, intervalInMs, exceededErrorMessage) => {
    let start = Date.now();
    let numOps = 0;
    return (...args) => tslib_1.__awaiter(void 0, void 0, void 0, function* () {
        const now = Date.now();
        const elapsed = now - start;
        if (elapsed > intervalInMs) {
            start = now;
            numOps = 0;
        }
        if (numOps >= maxOps) {
            throw new errors_1.BridgeAPIError(exceededErrorMessage || 'Too many invocations.');
        }
        numOps = numOps + 1;
        return wrappedFn(...args);
    });
};
exports.withRateLimiter = withRateLimiter;


/***/ }),

/***/ 529:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.close = void 0;
const tslib_1 = __webpack_require__(163);
const bridge_1 = __webpack_require__(999);
const errors_1 = __webpack_require__(712);
const callBridge = (0, bridge_1.getCallBridge)();
const close = (payload) => tslib_1.__awaiter(void 0, void 0, void 0, function* () {
    try {
        const success = yield callBridge('close', payload);
        if (success === false) {
            throw new errors_1.BridgeAPIError("this resource's view is not closable.");
        }
    }
    catch (e) {
        throw new errors_1.BridgeAPIError("this resource's view is not closable.");
    }
});
exports.close = close;


/***/ }),

/***/ 288:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.createHistory = void 0;
const tslib_1 = __webpack_require__(163);
const bridge_1 = __webpack_require__(999);
const callBridge = (0, bridge_1.getCallBridge)();
const createHistory = () => tslib_1.__awaiter(void 0, void 0, void 0, function* () {
    const history = yield callBridge('createHistory');
    history.listen((location) => {
        history.location = location;
    });
    return history;
});
exports.createHistory = createHistory;


/***/ }),

/***/ 7:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.getContext = void 0;
const bridge_1 = __webpack_require__(999);
const callBridge = (0, bridge_1.getCallBridge)();
const getContext = () => {
    return callBridge('getContext');
};
exports.getContext = getContext;


/***/ }),

/***/ 837:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
const tslib_1 = __webpack_require__(163);
tslib_1.__exportStar(__webpack_require__(225), exports);


/***/ }),

/***/ 616:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.refresh = void 0;
const tslib_1 = __webpack_require__(163);
const bridge_1 = __webpack_require__(999);
const errors_1 = __webpack_require__(712);
const callBridge = (0, bridge_1.getCallBridge)();
const refresh = (payload) => tslib_1.__awaiter(void 0, void 0, void 0, function* () {
    const success = yield callBridge('refresh', payload);
    if (success === false) {
        throw new errors_1.BridgeAPIError("this resource's view is not refreshable.");
    }
});
exports.refresh = refresh;


/***/ }),

/***/ 904:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.submit = void 0;
const tslib_1 = __webpack_require__(163);
const bridge_1 = __webpack_require__(999);
const errors_1 = __webpack_require__(712);
const callBridge = (0, bridge_1.getCallBridge)();
const submit = (payload) => tslib_1.__awaiter(void 0, void 0, void 0, function* () {
    const success = yield callBridge('submit', payload);
    if (success === false) {
        throw new errors_1.BridgeAPIError("this resource's view is not submittable.");
    }
});
exports.submit = submit;


/***/ }),

/***/ 225:
/***/ ((__unused_webpack_module, exports, __webpack_require__) => {


Object.defineProperty(exports, "__esModule", ({ value: true }));
exports.view = void 0;
const submit_1 = __webpack_require__(904);
const close_1 = __webpack_require__(529);
const refresh_1 = __webpack_require__(616);
const createHistory_1 = __webpack_require__(288);
const getContext_1 = __webpack_require__(7);
exports.view = {
    submit: submit_1.submit,
    close: close_1.close,
    refresh: refresh_1.refresh,
    createHistory: createHistory_1.createHistory,
    getContext: getContext_1.getContext
};


/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/compat get default export */
/******/ 	(() => {
/******/ 		// getDefaultExport function for compatibility with non-harmony modules
/******/ 		__webpack_require__.n = (module) => {
/******/ 			var getter = module && module.__esModule ?
/******/ 				() => (module['default']) :
/******/ 				() => (module);
/******/ 			__webpack_require__.d(getter, { a: getter });
/******/ 			return getter;
/******/ 		};
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/define property getters */
/******/ 	(() => {
/******/ 		// define getter functions for harmony exports
/******/ 		__webpack_require__.d = (exports, definition) => {
/******/ 			for(var key in definition) {
/******/ 				if(__webpack_require__.o(definition, key) && !__webpack_require__.o(exports, key)) {
/******/ 					Object.defineProperty(exports, key, { enumerable: true, get: definition[key] });
/******/ 				}
/******/ 			}
/******/ 		};
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/hasOwnProperty shorthand */
/******/ 	(() => {
/******/ 		__webpack_require__.o = (obj, prop) => (Object.prototype.hasOwnProperty.call(obj, prop))
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/make namespace object */
/******/ 	(() => {
/******/ 		// define __esModule on exports
/******/ 		__webpack_require__.r = (exports) => {
/******/ 			if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 				Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 			}
/******/ 			Object.defineProperty(exports, '__esModule', { value: true });
/******/ 		};
/******/ 	})();
/******/ 	
/************************************************************************/
var __webpack_exports__ = {};
// This entry need to be wrapped in an IIFE because it need to be isolated against other modules in the chunk.
(() => {
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": () => (__WEBPACK_DEFAULT_EXPORT__)
/* harmony export */ });
/* harmony import */ var _forge_bridge__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(788);
/* harmony import */ var _forge_bridge__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_forge_bridge__WEBPACK_IMPORTED_MODULE_0__);


async function getIssue(issueId) {
    const response = await (0,_forge_bridge__WEBPACK_IMPORTED_MODULE_0__.invoke)('getIssue', { issueId });
    console.log(response);
}

async function getActiveSprintIssues() {
    return await (0,_forge_bridge__WEBPACK_IMPORTED_MODULE_0__.invoke)('getActiveSprintIssues');
}

async function orderIssueBeforeOther(issue, rankBeforeIssue) {
    return await (0,_forge_bridge__WEBPACK_IMPORTED_MODULE_0__.invoke)('orderIssueBeforeOther', { issue, rankBeforeIssue });
}

async function setStorage(key, value) {
    await (0,_forge_bridge__WEBPACK_IMPORTED_MODULE_0__.invoke)('setStorage', { key, value });
}

async function getStorage(key) {
    return await (0,_forge_bridge__WEBPACK_IMPORTED_MODULE_0__.invoke)('getStorage', {key});
}

const forge = {
    getIssue,
    getActiveSprintIssues,
    orderIssueBeforeOther,
    setStorage,
    getStorage,
}

/* harmony default export */ const __WEBPACK_DEFAULT_EXPORT__ = (forge);

})();

window.forge = __webpack_exports__["default"];
/******/ })()
;