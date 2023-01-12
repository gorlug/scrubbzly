import { invoke } from "@forge/bridge";

async function getIssue(issueId) {
    const response = await invoke('getIssue', { issueId });
    console.log(response);
}

async function getActiveSprintIssues() {
    return await invoke('getActiveSprintIssues');
}

async function orderIssueBeforeOther(issue, rankBeforeIssue) {
    return await invoke('orderIssueBeforeOther', { issue, rankBeforeIssue });
}

async function setStorage(key, value) {
    await invoke('setStorage', { key, value });
}

async function getStorage(key) {
    const storageResult = await invoke('getStorage', {key});
    if (typeof storageResult === 'object' && Object.keys(storageResult).length === 0) {
        return null;
    }
    return storageResult;
}

async function deleteStorage(key) {
    return await invoke('deleteStorage', {key});
}

const forge = {
    getIssue,
    getActiveSprintIssues,
    orderIssueBeforeOther,
    setStorage,
    getStorage,
    deleteStorage
}

export default forge;
