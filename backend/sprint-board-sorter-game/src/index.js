import Resolver from '@forge/resolver';
import api, {route} from '@forge/api';

const resolver = new Resolver();

resolver.define('getIssue', async (req) => {
    try {
        const response = await api
            .asApp()
            .requestJira(
                route`/rest/api/3/issue/RS-1?fields=summary,description`,
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
    console.log('abc bbq', `/rest/api/3/search?jql=${('Sprint in openSprints() AND Sprint not in futureSprints()')}`)
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

export const handler = resolver.getDefinitions();

