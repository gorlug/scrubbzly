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

const forge = {
    getIssue,
    getActiveSprintIssues,
    orderIssueBeforeOther
}

export default forge;
