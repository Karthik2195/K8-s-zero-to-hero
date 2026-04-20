# Kubernetes Troubleshooting: From Zero to Hero

This repository provides a comprehensive guide to troubleshooting Kubernetes clusters, from basic concepts to advanced techniques.

**Author:** Karthik Reddy Vadde

## Structure

- [01-basics/](zero-to-hero/01-basics/) - Fundamental Kubernetes troubleshooting
- [02-intermediate/](zero-to-hero/02-intermediate/) - Intermediate troubleshooting scenarios
- [03-advanced/](zero-to-hero/03-advanced/) - Advanced debugging and optimization
- [common-errors/](zero-to-hero/common-errors/) - Detailed guides for common errors
- [scripts/](scripts/) - Useful scripts for troubleshooting

## Getting Started

1. Ensure you have access to a Kubernetes cluster
2. Install kubectl and other necessary tools
3. Start with the basics section
4. Run the health check script: `./scripts/check-cluster.sh`

## Scripts

- `check-cluster.sh`: Comprehensive cluster health check script
  - Run `./scripts/check-cluster.sh` for basic diagnostics
  - Run `./scripts/check-cluster.sh --help` for usage and common issues guide

## Prerequisites

- Kubernetes cluster (local or remote)
- kubectl configured
- Basic understanding of containers and orchestration

## Contributing

Feel free to contribute by adding more troubleshooting guides or scripts.

**Maintainer:** Karthik Reddy Vadde

## License

This project is open source. See LICENSE for details.
