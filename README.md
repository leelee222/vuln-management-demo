### Automated Vulnerability Management & Patching in a DevSecOps Pipeline

*A hands-on project demonstrating continuous dependency, container, and image vulnerability management.*

---

## **Project Overview**

This project focuses on **automating vulnerability detection, remediation, and validation** across application dependencies and container images.

It demonstrates how a DevSecOps engineer:

* Detects vulnerabilities early
* Automates updates
* Re-scans after patching
* Enforces security gates in CI/CD

This is **Week 11** of my Month 3 DevSecOps roadmap.

---

## **Tech Stack**

| Category               | Tools                         |
| ---------------------- | ----------------------------- |
| Dependency Updates     | Dependabot / Renovate         |
| Vulnerability Scanning | Trivy, Snyk, Grype |
| Container Security     | Docker, Trivy                 |
| CI/CD                  | GitHub Actions                |
| IaC                    | Terraform          |

---

## **Features**

### ✔ **Automated Dependency Updates**

* Dependabot scans dependencies daily
* Auto-creates PRs for vulnerable packages
* Supports npm / pip / Docker / GitHub Actions

### ✔ **Continuous Vulnerability Scanning**

* Scans source code dependencies
* Scans container images
* Fails pipeline on high / critical vulnerabilities

### ✔ **Automated Patch Validation**

* Re-runs scans after dependency updates
* Confirms vulnerabilities are resolved
* Prevents merging insecure changes

### ✔ **Security Gates**

* CI/CD pipeline blocks deployments if vulnerabilities exceed thresholds

---

## **Project Structure**

```
vuln-management-demo/
 ├── app/
 │    ├── package.json (Node.js dependencies)
 │    ├── requirements.txt (Python dependencies)
 │    ├── index.js (Express API server)
 │    └── Dockerfile (Container build instructions)
 ├── .github/
 │    ├── dependabot.yml (Automated dependency updates)
 │    └── workflows/
 │         └── vulnerability-pipeline.yml (CI/CD security pipeline)
 ├── scripts/
 │    ├── local-scan.sh (Run scans locally)
 │    └── install-trivy.sh (Install Trivy scanner)
 ├── docs/
 │    ├── vulnerability_workflow.md (Technical workflow docs)
 │    └── JUNIOR_DEVSECOPS_GUIDE.md (Beginner-friendly guide)
 └── README.md
```

**Note:** Workflows are in `.github/workflows/` because that's where GitHub Actions **requires** them to be. See [`docs/FOLDER_STRUCTURE_EXPLAINED.md`](docs/FOLDER_STRUCTURE_EXPLAINED.md) for details.

---

## **How It Works**

### **1️⃣ Automated Dependency Updates (Dependabot)**

```yaml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "daily"
```

Dependabot automatically:

* Detects vulnerable dependencies
* Opens PRs with fixes
* Includes security advisories

---

### **2️⃣ Container Image Vulnerability Scanning (Trivy)**

```yaml
- name: Scan image
  uses: aquasecurity/trivy-action@v0.19.0
  with:
    image-ref: myapp:latest
    severity: CRITICAL,HIGH
    exit-code: 1
```

Pipeline fails if high or critical vulnerabilities are found.

---

### **3️⃣ Dependency Scanning (Trivy / Snyk)**

```yaml
- name: Dependency Scan
  uses: aquasecurity/trivy-action@v0.19.0
  with:
    scan-type: fs
    severity: CRITICAL,HIGH
```

---

### **4️⃣ Patch & Re-scan Workflow**

1. Vulnerability detected
2. Dependabot opens PR
3. CI pipeline scans PR
4. Vulnerability fixed
5. Pipeline passes
6. PR merged

This mimics real enterprise workflows.

---

## **Local Testing**

Scan filesystem locally:

```bash
trivy fs .
```

Scan Docker image:

```bash
docker build -t vuln-demo .
trivy image vuln-demo
```

---

## **Documentation**

See `docs/vulnerability_workflow.md` for:

* Vulnerability lifecycle
* Patch management strategy
* Severity thresholds
* CI/CD enforcement logic

---

## **What This Project Demonstrates**

* Continuous vulnerability management
* Automated dependency updates
* Container image security
* CI/CD security gates
* Production-grade DevSecOps practices

This project proves understanding beyond “just scanning” - it shows **ownership of security over time**.

---

## **Let’s Connect**

If you’re interested in DevSecOps, Cloud Security, or Automation - let’s talk 👋
