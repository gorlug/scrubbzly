import { invoke } from "@forge/bridge";

async function getIssue() {
    const response = await invoke('getIssue');
    console.log(response);
}

async function getActiveSprintIssues() {
    return await invoke('getActiveSprintIssues');
}

async function getActiveSprintIssuesMocked() {
    return Promise.resolve({
        "expand": "schema,names",
        "startAt": 0,
        "maxResults": 50,
        "total": 2,
        "issues": [
            {
                "expand": "operations,versionedRepresentations,editmeta,changelog,renderedFields",
                "id": "10003",
                "self": "https://api.atlassian.com/ex/jira/71000936-9702-4ae5-8892-d5eb8cd631d6/rest/api/3/issue/10003",
                "key": "RS-3",
                "fields": {
                    "summary": "Jira B"
                }
            },
            {
                "expand": "operations,versionedRepresentations,editmeta,changelog,renderedFields",
                "id": "10002",
                "self": "https://api.atlassian.com/ex/jira/71000936-9702-4ae5-8892-d5eb8cd631d6/rest/api/3/issue/10002",
                "key": "RS-2",
                "fields": {
                    "summary": "Jira A"
                }
            }
        ]
    })
}

const forge = {
    getIssue,
    getActiveSprintIssues,
    getActiveSprintIssuesMocked
}

export default forge;
