# 🕷️ Spider All-in-One Node

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub Stars](https://img.shields.io/github/stars/ponrawat04/spider-all-in-one-node?style=social)](https://github.com/ponrawat04/spider-all-in-one-node)
[![GitHub Issues](https://img.shields.io/github/issues/ponrawat04/spider-all-in-one-node)](https://github.com/ponrawat04/spider-all-in-one-node/issues)

> A comprehensive Web3 toolkit that brings all essential blockchain tools together in one place.

## 🌟 Features

- **🔗 Multi-Chain Support** - Work with multiple blockchains seamlessly
- **💰 Web3 Tools** - Complete set of Web3 development utilities
- **🐳 Docker Integration** - Easy deployment with Docker & Docker Compose
- **⚙️ Auto Configuration** - Automated setup with sensible defaults
- **📊 Real-time Monitoring** - Monitor your nodes and transactions
- **🔐 Security First** - Built-in security best practices
- **🌍 P2P Network** - Full peer-to-peer network support
- **📱 API Ready** - RESTful API for easy integration

## 🚀 Quick Start

### Prerequisites
- Docker 20.10+
- Docker Compose 1.29+
- 2GB RAM minimum
- Internet connection

### Installation (Automated)

```bash
# Clone the repository
git clone https://github.com/ponrawat04/spider-all-in-one-node.git
cd spider-all-in-one-node

# Run the installer
chmod +x install.sh
./install.sh
```

### Manual Installation

```bash
# Copy environment template
cp .env.example .env

# Start services
docker-compose up -d

# View logs
docker-compose logs -f
```

## 📋 Configuration

Edit `.env` file to customize:

```bash
# Node Configuration
NODE_ROLE=validator          # validator, archive, light
P2P_BOOTSTRAP=/dnsaddr/...  # Bootstrap node address

# Port Configuration
HTTP_PORT=3000              # HTTP API port
P2P_PORT=4001               # P2P network port

# Data Directory
DATA_DIR=./spider_data       # Local data storage path
```

## 🎯 Usage

### Check Node Status
```bash
docker-compose ps
docker-compose logs -f
```

### Interact with Node
```bash
# HTTP API
curl http://localhost:3000/api/status

# Web3 JSON-RPC (if enabled)
curl -X POST http://localhost:3000 \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}'
```

### Manage Services
```bash
# Start
docker-compose up -d

# Stop
docker-compose down

# Restart
docker-compose restart

# View logs
docker-compose logs -f [service-name]
```

## 🛠️ Development

### Project Structure
```
spider-all-in-one-node/
├── install.sh              # Installation script
├── docker-compose.yml      # Docker Compose configuration
├── .env.example            # Environment template
├── README.md               # This file
├── CONTRIBUTING.md         # Contribution guidelines
├── DONATION.md             # Support the project
└── tests/                  # Test files
```

### Building from Source

```bash
# Install dependencies
npm install

# Build
npm run build

# Test
npm test

# Run locally
npm start
```

## 📚 Documentation

- [Installation Guide](./docs/INSTALLATION.md)
- [Configuration Guide](./docs/CONFIG.md)
- [API Reference](./docs/API.md)
- [Contributing Guide](./CONTRIBUTING.md)

## 💰 Support

This project is maintained by volunteers. Please consider supporting our development:

### Donate Cryptocurrency

**Bitcoin (BTC)**
```
bc1qjz4m8nq0j8xz5k2p9v3x4y5z6w7a8b9c0d1e2f
```

**Ethereum (ETH) & ERC-20 Tokens**
```
0x1234567890abcdef1234567890abcdef12345678
```

👉 See [DONATION.md](./DONATION.md) for more donation options.

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](./CONTRIBUTING.md) for details on:
- How to submit issues
- How to submit pull requests
- Code style guidelines
- Development setup

## 📄 License

This project is licensed under the MIT License - see [LICENSE](./LICENSE) file for details.

## ⚠️ Disclaimer

This software is provided "as-is" without warranty. Use at your own risk. Always test thoroughly in a non-production environment first.

## 🔗 Links

- **GitHub**: https://github.com/ponrawat04/spider-all-in-one-node
- **Issues**: https://github.com/ponrawat04/spider-all-in-one-node/issues
- **Discussions**: https://github.com/ponrawat04/spider-all-in-one-node/discussions

## 👨‍💻 Author

**Ponrawat** - [@ponrawat04](https://github.com/ponrawat04)

---

**Made with ❤️ for the Web3 community**

⭐ If you find this useful, please give it a star!
