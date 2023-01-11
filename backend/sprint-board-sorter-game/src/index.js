import Resolver from '@forge/resolver';
import api, {route, storage} from '@forge/api';

const resolver = new Resolver();

resolver.define('getIssue', async (req) => {
    const {issueId} = req.payload;
    try {
        const response = await api
            .asApp()
            .requestJira(
                route`/rest/api/3/issue/${issueId}?fields=summary,description`,
                {
                    headers: {
                        Accept: 'application/json',
                    },
                }
            );

        return await response.json();
    } catch (error) {
        console.log(error);
    }
});

resolver.define('getActiveSprintIssues', async (req) => {
    const response = await api
        .asApp()
        .requestJira(
            route`/rest/api/3/search?fields=summary&jql=${('Sprint in openSprints() AND Sprint not in futureSprints()')}`,
            {
                headers: {
                    Accept: 'application/json',
                },
            }
        );

    return await response.text();
});

resolver.define('orderIssueBeforeOther', async (req) => {
    const {issue, rankBeforeIssue} = req.payload;
    console.log('order issue', issue, rankBeforeIssue);
    const body = {
        rankBeforeIssue,
        issues: [issue]
    }
    const url = route`/rest/agile/1.0/issue/rank`;
    console.log('url', url);
    const response = await api.asApp().requestJira(url, {
        method: 'PUT',
        headers: {
            Accept: 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(body)
    })
    console.log('response', response.status);
})

resolver.define('setStorage', async (req) => {
    const {key, value} = req.payload;
    await storage.set(key, value);
});

resolver.define('getStorage', async (req) => {
    const {key} = req.payload;
    return await storage.get(key);
});

export const handler = resolver.getDefinitions();

