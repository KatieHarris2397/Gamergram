# Nexlayer — Gamergram

<!-- nexlayer:meta version=1 analyzed=2026-06-18T20:44:20Z repo=https://github.com/KatieHarris2397/Gamergram branch=master -->

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
Gamergram is a MERN stack social media application that allows users to create posts, like, and comment on content with integrated Google OAuth authentication.
<!-- nexlayer:end -->

## Technology Stack
<!-- nexlayer:section agent-managed=tech_stack -->
| Name | Kind | Version | Detected From |
|------|------|---------|---------------|
| Node.js | language | 14.x | package.json |
| Express | framework | 4.17.1 | package.json |
| MongoDB | database | 5.x | package.json |
| React | framework | Not specified | README.md |
| Mongoose | tool | 5.9.19 | package.json |
<!-- nexlayer:end -->

## Repository Structure
<!-- nexlayer:section agent-managed=structure_map -->
- client/ — React frontend application
- routes/ — Express API route handlers
- models/ — Mongoose database schemas
- middleware/ — Express request middleware
- app.js — Server entry point and configuration
- db.js — Database connection logic
<!-- nexlayer:end -->

## External Services Required
<!-- nexlayer:section agent-managed=external_deps -->
Services that must be configured separately (not deployed by Nexlayer):

- MongoDB Atlas or Local MongoDB
- Google OAuth API
- SendGrid API (nodemailer-sendgrid-transport)
<!-- nexlayer:end -->

## Local Development Setup
<!-- nexlayer:section user-editable=local_setup -->
### Prerequisites

- Node.js >= 14
- npm >= 6

### Environment variables

Copy `.env.example` to `.env.local` and fill in:

```
MONGO_URI=mongodb://localhost:27017/gamergram
JWT_SECRET=your_jwt_secret
GOOGLE_CLIENT_ID=your_google_id
SENDGRID_API_KEY=your_api_key
```

### Steps

1. `npm install` — Install backend dependencies
2. `cd client && npm install` — Install frontend dependencies
3. `node app.js` — Start the server
4. `cd client && npm start` — Start the React frontend

<!-- nexlayer:end -->

## Nexlayer Setup
<!-- nexlayer:section agent-managed=nexlayer_setup -->
### Pod Environment Variables

| Pod | Variable | Value | Kind |
|-----|----------|-------|------|
| `app` | `NODE_ENV` | `"production"` | plain |
| `app` | `PORT` | `"3000"` | plain |
| `app` | `HOSTNAME` | `"0.0.0.0"` | plain |
| `app` | `MONGO_URI` | `"mongodb://mongo.pod:27017/gamergram"` | plain |

### nexlayer.yaml

```yaml
application:
  name: gamergram
  pods:
    - name: app
      image: "registry.nexlayer.io/user_01kna6j8vrcfj9q0wjtq5qsq3n/gamergram:9edc79c-fix1"
      path: /
      servicePorts:
        - 3000
      vars:
        NODE_ENV: "production"
        PORT: "3000"
        HOSTNAME: "0.0.0.0"
        MONGO_URI: "mongodb://mongo.pod:27017/gamergram"
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
| api | mirror.gcr.io/library/node:14-alpine | 5000 | web |
| frontend | mirror.gcr.io/library/node:14-alpine | 3000 | web |
| mongodb | mirror.gcr.io/library/mongo:5 | 27017 | database |

### Deployment notes

- The API pod connects to the database via mongodb.pod:27017
- The frontend is treated as a separate pod to maintain the one-service-per-pod rule
- Images are mirrored via gcr.io to comply with Nexlayer platform requirements

<!-- nexlayer:end -->

## Build Notes
<!-- nexlayer:section user-editable=build_notes -->
<!-- Add notes for future builds here — preserved across re-analysis -->
<!-- nexlayer:end -->

## Nexlayer Configuration
<!-- nexlayer:section agent-managed=nexlayer_config -->
**Last deployed:** 2026-06-18T20:53:01Z  
**Live URL:** https://kitbear-studio-gamergram.cloud.nexlayer.ai  
**Runtime:** node · **Port:** 3000  
**Deploy branch:** master  

```yaml
application:
  name: gamergram
  pods:
    - name: app
      image: "registry.nexlayer.io/user_01kna6j8vrcfj9q0wjtq5qsq3n/gamergram:9edc79c-fix1"
      path: /
      servicePorts:
        - 3000
      vars:
        NODE_ENV: "production"
        PORT: "3000"
        HOSTNAME: "0.0.0.0"
        MONGO_URI: "mongodb://mongo.pod:27017/gamergram"
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
| 2026-06-18T20:44:20Z | analyzed | initial repo analysis |
| 2026-06-18T20:53:01Z | success | deployed https://kitbear-studio-gamergram.cloud.nexlayer.ai |
<!-- nexlayer:end -->
