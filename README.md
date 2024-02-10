# Metadelta Demo Database

This is an example database showcasing the
[Metadelta](https://invariant.club/#metadelta) tool.

In particular, we have:

- A sample Hasura database,
- A few commits making some changes,
- Some [scripts](./scripts) showcasing how to run a local diff,
- A [GitHub Actions integration](#github-action-integration) showing how to integrate
  this into a "real" project.


### GitHub Action Integration

If you take a look at the [GitHub action
workflow](./.github/workflows/compute-permission-diff.yaml) you will see a
small collection of steps showing how to run the Metadelta on a PR.

The steps are as follows:

1. Clone the PR branch and the main branch to temp directories,
2. Run `metadelta-cli` (from Docker) outputting a `diff.json` file,
3. If there was a difference:
  - Upload it as an artifact to GitHub,
  - Comment with a link to the [Metadelta
  UI](http://metadelta.invariant.club/) to view the artifact.

The only requirement for this to work is to configure a GitHub access token in
the [settings of the UI](https://metadelta.invariant.club/settings). The reason for this is [GitHub _requires_ a personal token for downloading artifacts](https://docs.github.com/en/rest/actions/artifacts?apiVersion=2022-11-28#download-an-artifact).

You are, of course, free to upload your artifacts to another
(publically-accessible) location, and then [just use the `src` parameter on
the UI](https://metadelta.invariant.club/new) to grab the diff that way.
