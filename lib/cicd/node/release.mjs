import { Octokit, App } from "octokit";
import { owner, repo, sprintMergeUniqueRegex } from "./constants.mjs";
import fetch from "node-fetch";

const secret = process.argv[2];

const octokit = new Octokit({
  auth: secret,
});

async function main(octokit) {
  // STEP 1: Authenticate
  const {
    data: { login },
  } = await octokit.rest.users.getAuthenticated();

  // STEP 2: Get the last commmit
  const lastCommit = (
    await octokit.request(`GET /repos/${owner}/${repo}/commits/main`)
  ).data.commit;

  // STEP 3: Prepare the release version, name, tag and body

  let releaseTagName = "";
  let releaseName = "";
  let releaseBody = "";

  // set MINOR version number to n where the merged branch's name is "Aktion-Sodis/sprint-n".
  if (sprintMergeUniqueRegex.test(lastCommit.message)) {
    const sprintNumber = lastCommit.message.charAt(
      lastCommit.message.length - 1
    );
    releaseTagName = `v1.${sprintNumber}.0`;
    releaseName = `v1.${sprintNumber}.0`;
    releaseBody = `See the changelog under the pull request of sprint-${sprintNumber}.`;
  } else {
    // increment PATCH version once.
    const { data: latestRelease } = await octokit.request(
      `GET /repos/${owner}/${repo}/releases/latest`
    );
    const patchVersionOfLatestRelease = parseInt(
      latestRelease.tag_name.split(".")[2]
    );
    const minorversionOfLatestRelease = latestRelease.tag_name.split(".")[1];
    const majorVersionOfLatestRelease = latestRelease.tag_name.split(".")[0];

    releaseTagName = `${majorVersionOfLatestRelease}.${minorversionOfLatestRelease}.${
      patchVersionOfLatestRelease + 1
    }`;
    releaseName = releaseTagName;
    const commitDataResponse = await fetch(lastCommit.url);
    const commitData = await commitDataResponse.json();
    releaseBody = `See the changelog [here](${commitData.html_url}).`;
  }

  // STEP 4: Publish the release
  await octokit.request(`POST /repos/${owner}/${repo}/releases`, {
    tag_name: releaseTagName,
    name: releaseName,
    body: releaseBody,
    draft: false,
    prerelease: false,
    generate_release_notes: false,
  });
}

main(octokit).catch((e) => console.error(e.stack));
