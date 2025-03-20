I need to create a GitHub Actions workflow for my repository. Here are the standards and requirements for the workflow:

1. **Workflow Name**: The workflow should have a descriptive name that reflects its purpose (e.g., "Build and Test", "Deploy to Production").
2. **Triggers**:
  - The workflow should trigger on `push` to the `main` branch.
  - It should also trigger on `pull_request` events targeting the `main` branch.
3. **Environment Matrix**:
  - The workflow should support a matrix of environments (e.g., Node.js versions, Python versions, etc.).
  - For example, if it's a Node.js project, test against Node.js versions `18`, `20`, and `22`.
4. **Steps**:
  - Checkout the repository using `actions/checkout@v4`.
  - Set up the required environment (e.g., Node.js, Python, Docker, etc.).
  - Install dependencies using the appropriate package manager (e.g., `npm install`, `pip install -r requirements.txt`).
  - Run tests using the standard testing framework for the language (e.g., `npm test`, `pytest`).
  - If applicable, build the project (e.g., `npm run build`).
5. **Secrets and Environment Variables**:
  - Use secrets stored in GitHub Actions (e.g., `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`) for secure operations.
  - Use environment variables for configuration where applicable.
6. **Artifacts**:
  - If the workflow generates build artifacts, upload them using `actions/upload-artifact@v4`.
7. **Notifications**:
  - Notify the team on Slack or via email if the workflow fails.
8. **Error Handling**:
  - Ensure the workflow fails gracefully with clear error messages.
9. You should also look at the existing workflows in `.github/workflows` as a reference.
10. Where possible, use reusable workflows to avoid duplication and improve maintainability.
11. Where possible, use internal Actions vs. marketplace Actions to avoid security issues.
12. When referring to marketplace Actions, always use a specific commit SHA or version tag instead of a tag or branch name for security reasons.
