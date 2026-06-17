# Nexlayer — Gamergram

<!-- nexlayer:meta version=1 analyzed=2026-06-17T19:54:54Z repo=https://github.com/KatieHarris2397/Gamergram branch=master -->

> **For AI agents (Claude Code, Cursor, Gemini CLI, Copilot):**
> This file is the **project context** for this Nexlayer deployment — tech stack, env vars, secrets, live URL.
> For full platform detail (nexlayer.yaml schema, Dockerfile rules, CI/CD, task recipes) read **`nexlayer.skills`** in this repo.
>
> **Critical rules (full detail in `nexlayer.skills`):**
> - Inter-pod refs: `${podName:port}` only — never `localhost` or bare hostnames
> - Docker Hub images: prefix with `mirror.gcr.io/library/` — bare tags fail on the cluster
> - Secrets: set in the Nexlayer dashboard — never commit to `nexlayer.yaml` or Dockerfile
>
> **This file:** `agent-managed` sections update automatically. `user-editable` sections (Local Development Setup, Nexlayer Deployment Plan, Build Notes) are yours — preserved across re-analysis.

## Project Summary
<!-- nexlayer:section agent-managed=project_summary -->
Gamergram is a MERN stack social media application that allows users to create posts, like, and comment, featuring Google OAuth authentication.
<!-- nexlayer:end -->

## Technology Stack
<!-- nexlayer:section agent-managed=tech_stack -->
| Name | Kind | Version | Detected From |
|------|------|---------|---------------|
| Node.js | language | 22 | Dockerfile |
| Express | framework | 4.17.1 | package.json |
| React | framework | Not specified | README.md, package.json |
| MongoDB | database | Not specified | package.json, db.js |
| Mongoose | tool | 5.9.19 | package.json |
<!-- nexlayer:end -->

## Repository Structure
<!-- nexlayer:section agent-managed=structure_map -->
- client/ — React frontend source code
- models/ — Mongoose schema definitions
- routes/ — Express API route handlers
- middleware/ — Express middleware functions
- app.js — Application entry point and server configuration
- db.js — Database connection logic
<!-- nexlayer:end -->

## External Services Required
<!-- nexlayer:section agent-managed=external_deps -->
Services that must be configured separately (not deployed by Nexlayer):

- Google OAuth API
- SendGrid API (nodemailer-sendgrid-transport)
<!-- nexlayer:end -->

## Local Development Setup
<!-- nexlayer:section user-editable=local_setup -->
### Prerequisites

- Node.js >= 14
- npm

### Environment variables

Copy `.env.example` to `.env.local` and fill in:

```
MONGODB_URI=mongodb://localhost:27017/gamergram
GOOGLE_CLIENT_ID=your-google-id
JWT_SECRET=your-jwt-secret
```

### Steps

1. `npm install` — Install server-side dependencies
2. `cd client && npm install` — Install frontend dependencies
3. `node app.js` — Start backend server
4. `cd client && npm start` — Start React development server

<!-- nexlayer:end -->

## Nexlayer Setup
<!-- nexlayer:section agent-managed=nexlayer_setup -->
### Pod Environment Variables

| Pod | Variable | Value | Kind |
|-----|----------|-------|------|
| `app` | `NODE_ENV` | `production` | plain |
| `app` | `PORT` | `"3000"` | plain |
| `app` | `HOSTNAME` | `"0.0.0.0"` | plain |
| `app` | `ROOT_URL` | `"<% URL %>"` | plain |

### nexlayer.yaml

```yaml
application:
  name: rich-sage-gamergram
  pods:
    - name: app
      image: "# filled by pipeline"
      path: /
      servicePorts:
        - 3000
      vars:
        NODE_ENV: production
        PORT: "3000"
        HOSTNAME: "0.0.0.0"
        ROOT_URL: "<% URL %>"
    - name: mongo
      image: mirror.gcr.io/library/mongo:7
      servicePorts:
        - 27017
      vars: {}
```
<!-- nexlayer:end -->

## Nexlayer Deployment Plan
<!-- nexlayer:section user-editable=deployment_plan -->
### Pod Topology

| Pod | Image | Port | Role |
|-----|-------|------|------|
| frontend | mirror.gcr.io/library/node:16-alpine | 3000 | web |
| backend | mirror.gcr.io/library/node:16-alpine | 5000 | web |
| mongodb | mirror.gcr.io/library/mongo:latest | 27017 | database |

### Inter-pod environment variables

- `frontend` pod: `REACT_APP_API_URL=${backend:5000}`
- `backend` pod: `MONGODB_URI=mongodb://${mongodb:27017}/gamergram`

### Deployment notes

- Frontend pod communicates with backend using ${backend:5000}
- Backend pod communicates with database using ${mongodb:27017}
- Node.js 16-alpine used to ensure compatibility with older Mongoose/React dependencies found in package.json

<!-- nexlayer:end -->

## Build Notes
<!-- nexlayer:section user-editable=build_notes -->
<!-- Add notes for future builds here — preserved across re-analysis -->
<!-- nexlayer:end -->

## Nexlayer Configuration
<!-- nexlayer:section agent-managed=nexlayer_config -->
**Last deployed:** 2026-06-17T23:02:11Z  
**Live URL:** https://kitbear-studio-rich-sage-gamergram.cloud.nexlayer.ai  
**Runtime:**  · **Port:** auto-detected  
**Deploy branch:** nexlayer  

```yaml
application:
  name: rich-sage-gamergram
  pods:
    - name: app
      image: "# filled by pipeline"
      path: /
      servicePorts:
        - 3000
      vars:
        NODE_ENV: production
        PORT: "3000"
        HOSTNAME: "0.0.0.0"
        ROOT_URL: "<% URL %>"
    - name: mongo
      image: mirror.gcr.io/library/mongo:7
      servicePorts:
        - 27017
      vars: {}
```
<!-- nexlayer:end -->

## Build History
<!-- nexlayer:section agent-managed=build_history -->
| Date | Status | Notes |
|------|--------|-------|
| 2026-06-17T22:54:48Z | analyzed | initial repo analysis |
| 2026-06-17T23:02:11Z | success | deployed https://kitbear-studio-rich-sage-gamergram.cloud.nexlayer.ai |
<!-- nexlayer:end -->

