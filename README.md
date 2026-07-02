# Tamarin Cross-Verification for Hash-Based Protocols

**Authors:** Hafeez Muhammed, Arun Natarajan  
**Advisor:** Dr. Vinod Pathari

---

## Overview

This repository serves as a **cross-verification tool** for the protocol models and resolution improvements developed in our main project repository, **[proverif-hash-resolution](https://github.com/Hafeez-hm/proverif-hash-resolution)**.

The primary motivation for this repository is to validate the security verification results obtained via our proposed ProVerif axioms using an independent, state-of-the-art symbolic verification tool (**Tamarin Prover**). By translating our protocol models into Tamarin's multiset rewriting framework, we ensure that the vulnerabilities and security guarantees identified in our main work are mathematically sound and methodology-agnostic.

---

## Repository Structure

The workspace is organized to keep protocol theories, evaluation scripts, and container resources modular.

```text
.
├── protocols/        # Contains the translated protocol sub-directories
│   ├── ike_full/     # Full IKEv2 theory files and scripts
│   ├── ike_simplified/        # Simplified IKEv2 theory files and scripts
│   ├── macs/         # Foundational MACs theory files and scripts
│   ├── proba_pk/     # Probabilistic PK theory files and scripts
│   ├── sigma/        # Sigma protocol theory files and scripts
│   └── wmf/          # Wide Mouth Frog theory files and scripts
├── Dockerfile        # Container environment configuration
└── README.md         # This documentation file
```

---

## Protocol Sources

The protocol specifications inside the `protocols/` directory are direct translations of the models from the **[proverif-hash-resolution](https://github.com/Hafeez-hm/proverif-hash-resolution)** repository. They have been adapted from ProVerif's applied pi-calculus representation into Tamarin's native multiset rewriting rules while preserving the core chosen-prefix collision logic and transcript variables.

---

## Execution Framework

To streamline the evaluation process, each protocol sub-directory contains a dedicated `run_proofs.sh` automation script.

### How `run_proofs.sh` Works

1. **Target Identification**
   - Automatically targets both `no_collision.spthy` and `collision.spthy` theory files.

2. **Lemma Iteration**
   - Sequentially executes the Tamarin engine against all predefined structural, sanity, and security lemmas.

3. **Result Parsing**
   - Tracks the evaluation status (**VERIFIED** or **FALSIFIED**) for each lemma.

4. **Summary Generation**
   - Extracts the raw outputs and generates a concise `summary.res` file in the same directory for quick review.

---

## Setup and Execution Guide

### 1. Pull the Docker Image

To ensure a consistent environment with all required Tamarin binaries and dependencies installed, pull the pre-configured Docker image.

```bash
docker pull hafeez2003/tamarin-cross-verification:v1.0
```

---

### 2. Run the Docker Container

Launch the interactive container and mount your local `protocols` directory so that generated summary files are written directly to your local workspace.

```bash
docker run -it \
  -v $(pwd)/protocols:/root/protocols \
  hafeez2003/tamarin-cross-verification:v1.0 \
  /bin/bash
```

---

### 3. Navigate to a Protocol Directory

For example, to verify the Sigma protocol:

```bash
cd /root/protocols/sigma
```

---

### 4. Execute the Proofs

Run the automation script.

```bash
bash run_proofs.sh
```

---

### 5. View the Results

The script prints its progress to the terminal. Once execution completes, inspect the generated summary file.

```bash
cat summary.res
```

Because the `protocols` directory is mounted as a Docker volume, the `summary.res` file will also appear immediately in your local workspace.

---

## Contact

**Hafeez Muhammed**

- GitHub: https://github.com/Hafeez-hm

**Arun Natarajan**

- GitHub: https://github.com/arunnats