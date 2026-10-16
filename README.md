# DevOps Lab — Complete 10 Hands-on Exercises

This repository contains full implementations, manifests, configuration files, Dockerfiles, test suites, and terminal execution screenshots for all 10 DevOps laboratory exercises.

## Repository Contents

| # | Exercise | Technologies | Directory |
|---|---|---|---|
| **01** | Kubernetes Getting Started | Minikube, kubectl, Pods, Services, Nginx | [`01-Kubernetes-Getting-Started`](./01-Kubernetes-Getting-Started) |
| **02** | Minikube + kubectl + Flask | Python, Flask, Docker, Deployment, NodePort | [`02-Minikube-Kubectl-Flask`](./02-Minikube-Kubectl-Flask) |
| **03** | Minikube Scaling with ReplicaSets | Flask, ReplicaSets, Pod Scaling, Self-Healing | [`03-Minikube-Scaling-Flask`](./03-Minikube-Scaling-Flask) |
| **04** | Docker Networking | Docker Bridge, Flask, MySQL, Redis, DNS | [`04-Docker-Networking`](./04-Docker-Networking) |
| **05** | Docker Security with AppArmor | Docker Security, AppArmor, Python Docker SDK | [`05-Docker-Security-AppArmor`](./05-Docker-Security-AppArmor) |
| **06** | Real-Time Monitoring & Alerting | Prometheus, Grafana, Python Metrics, Alerts | [`06-Grafana-Realtime-Monitoring`](./06-Grafana-Realtime-Monitoring) |
| **07** | Jenkins CI Automation | Jenkins LTS, CI Workflow, Python Unittest | [`07-Jenkins-CI-Automation`](./07-Jenkins-CI-Automation) |
| **08** | Jenkins Hello World Job | Jenkins Freestyle Job, Shell Scripting, Git SCM | [`08-Jenkins-Hello-World`](./08-Jenkins-Hello-World) |
| **09** | Jenkins Multi-Stage Pipeline | Declarative Pipeline (Build, Test, Deploy, Run) | [`09-Jenkins-Multi-Stage-Pipeline`](./09-Jenkins-Multi-Stage-Pipeline) |
| **10** | Multi-Node Multi-App Minikube | 3-Node Cluster, Pod Anti-Affinity, Catalog + Cart | [`10-Minikube-Multi-Node-Multi-App`](./10-Minikube-Multi-Node-Multi-App) |

---

## Technical Architecture & Execution Screenshots (All 10 Exercises)

### Exercise 01: Kubernetes Getting Started — Hello Pod & NodePort Service
![Exercise 01 Architecture](screenshots/Architecture-01-Kubernetes-Getting-Started.png)
![Exercise 01 Execution](screenshots/Exercise-01-Kubernetes-Getting-Started.png)

### Exercise 02: Deploy Flask App on Minikube with kubectl and YAML
![Exercise 02 Architecture](screenshots/Architecture-02-Minikube-Kubectl-Flask.png)
![Exercise 02 Execution](screenshots/Exercise-02-Minikube-Kubectl-Flask.png)

### Exercise 03: Scaling Flask App with ReplicaSets & Self-Healing
![Exercise 03 Architecture](screenshots/Architecture-03-Minikube-Scaling-Flask.png)
![Exercise 03 Execution](screenshots/Exercise-03-Minikube-Scaling-Flask.png)

### Exercise 04: Multi-Container Docker Networking (Bridge Network & DNS)
![Exercise 04 Architecture](screenshots/Architecture-04-Docker-Networking.png)
![Exercise 04 Execution](screenshots/Exercise-04-Docker-Networking.png)

### Exercise 05: Docker Security with Custom AppArmor Profile & Python SDK
![Exercise 05 Architecture](screenshots/Architecture-05-Docker-Security-AppArmor.png)
![Exercise 05 Execution](screenshots/Exercise-05-Docker-Security-AppArmor.png)

### Exercise 06: Real-Time Monitoring with Prometheus, Grafana, and Alerts
![Exercise 06 Architecture](screenshots/Architecture-06-Grafana-Realtime-Monitoring.png)
![Exercise 06 Execution](screenshots/Exercise-06-Grafana-Realtime-Monitoring.png)

### Exercise 07: Jenkins CI Automation Setup & Automated Unit Tests
![Exercise 07 Architecture](screenshots/Architecture-07-Jenkins-CI-Automation.png)
![Exercise 07 Execution](screenshots/Exercise-07-Jenkins-CI-Automation.png)

### Exercise 08: Jenkins Freestyle Hello World Shell Job Console Output
![Exercise 08 Architecture](screenshots/Architecture-08-Jenkins-Hello-World.png)
![Exercise 08 Execution](screenshots/Exercise-08-Jenkins-Hello-World.png)

### Exercise 09: Jenkins Multi-Stage Declarative Pipeline Execution
![Exercise 09 Architecture](screenshots/Architecture-09-Jenkins-Multi-Stage-Pipeline.png)
![Exercise 09 Execution](screenshots/Exercise-09-Jenkins-Multi-Stage-Pipeline.png)

### Exercise 10: Multi-Node Minikube Cluster with Pod Anti-Affinity & Multi-App
![Exercise 10 Architecture](screenshots/Architecture-10-Minikube-Multi-Node-Multi-App.png)
![Exercise 10 Execution](screenshots/Exercise-10-Minikube-Multi-Node-Multi-App.png)

---

## GitHub Deployment & Verification

### 1. Git Remote & Commit Timeline Verification
![Git Remote & History Check](screenshots/GitHub-Push-01-Remote-and-History.png)

### 2. Pushing Exercises to GitHub Repository
![Git Push to devops-lab1](screenshots/GitHub-Push-02-Execution.png)

### 3. Branch Status Verification
![Git Status Verification](screenshots/GitHub-Push-03-Verification.png)

---

## Quick Navigation & Architecture

Each exercise directory is fully self-contained and includes:
- Source code / manifests / configuration files
- Dedicated automation / runner scripts (`run.sh`)
- Comprehensive `README.md` with step-by-step procedures and troubleshooting
- Embedded `screenshots/` documenting the execution stages
