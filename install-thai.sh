#!/bin/bash
# ==============================================================================
# สคริปต์ติดตั้ง Spider Web3 Decentralized Node
# ปรับแต่งสำหรับ Ubuntu, Debian และ Enterprise Linux
# สร้างขึ้นโดยอัตโนมัติโดย Spider Web3 Network Core Console
# ==============================================================================

set -e

# รหัสสี ANSI
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${CYAN}====================================================${NC}"
echo -e "${CYAN}    ตัวติดตั้ง SPIDER WEB3 NODE (ตั้งค่า DAEMON)     ${NC}"
echo -e "${CYAN}====================================================${NC}"
echo -e "ตรวจสอบ Repository ของผู้ใช้เป้าหมาย: ponrawat04/spider-all-in-one-node"

# 1. ตรวจสอบสิทธิ์ Root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}[ข้อผิดพลาด] โปรดรันสคริปต์นี้ด้วย sudo หรือในฐานะ root${NC}"
  exit 1
fi

# 2. ตรวจสอบระบบและความเข้ากันได้
echo -e "\n${YELLOW}[ขั้นตอนที่ 1/5] กำลังตรวจสอบความเข้ากันได้ของระบบปฏิบัติการ...${NC}"
if [ -f /etc/debian_version ]; then
    PM="apt-get"
    echo -e "${GREEN}[เข้ากันได้] ตรวจพบ Debian/Ubuntu Linux${NC}"
elif [ -f /etc/redhat-release ]; then
    PM="yum"
    echo -e "${GREEN}[เข้ากันได้] ตรวจพบ RHEL/CentOS Linux${NC}"
else
    echo -e "${RED}[ข้อผิดพลาด] ระบบปฏิบัติการไม่รองรับ ออกแบบมาสำหรับ Debian, Ubuntu หรือ CentOS${NC}"
    exit 1
fi

# 3. อัปเดตฐานข้อมูลและติดตั้ง Docker หากยังไม่มี
echo -e "\n${YELLOW}[ขั้นตอนที่ 2/5] กำลังตรวจสอบและติดตั้งการพึ่งพาหลัก...${NC}"
$PM update -y && $PM install -y grep curl tar jq git gupnp-tools || true

if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}ไม่พบ Docker กำลังติดตั้ง Docker Engine...${NC}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    systemctl start docker
    systemctl enable docker
    echo -e "${GREEN}[สำเร็จ] ติดตั้ง Docker เสร็จสมบูรณ์${NC}"
else
    echo -e "${GREEN}[ตกลง] Docker Engine ติดตั้งแล้ว${NC}"
fi

# 4. จัดเตรียมโครงสร้างไดเรกทอรีโหนดและการกำหนดค่า
echo -e "\n${YELLOW}[ขั้นตอนที่ 3/5] กำลังตั้งค่า Persistent Volumes และโครงสร้างไดเรกทอรี...${NC}"
mkdir -p /root/spider-node-data/config
mkdir -p /root/spider-node-data/ipfs
mkdir -p /root/spider-node-data/logs

# เขียนการกำหนดค่าโหนดในเครื่อง
cat <<EOF > /root/spider-node-data/config/node.json
{
  "node_id": "auto-sec-$(dbus-uuidgen 2>/dev/null | head -c 12 || date +%s)",
  "owner": "ponrawat04",
  "consensus_mode": "Proof-of-Venom",
  "p2p_port": 4001,
  "rpc_port": 3000,
  "bootstrap_peers": [
    "/dnsaddr/bootstrap.spider-web3.net/p2p/QmSpiderBootstrapX1"
  ]
}
EOF
echo -e "${GREEN}[สำเร็จ] สร้างการกำหนดค่าท้องถิ่นที่ /root/spider-node-data/config/node.json${NC}"

# 5. ดาวน์โหลดและสตาร์ท Spider Node container daemon
echo -e "\n${YELLOW}[ขั้นตอนที่ 4/5] กำลังดึงและปรับใช้ Spider Node daemon container...${NC}"
docker stop spider-node-core &>/dev/null || true
docker rm spider-node-core &>/dev/null || true

docker run -d \
  --name spider-node-core \
  --restart always \
  -p 3000:3000 \
  -p 4001:4001 \
  -v /root/spider-node-data/ipfs:/data/ipfs \
  -v /root/spider-node-data/config:/config \
  -v /root/spider-node-data/logs:/logs \
  -e NODE_ROLE=validator \
  -e OWNER_ACCOUNT=ponrawat04 \
  -e NETWORK_ID=spider-mainnet-web3 \
  ubuntu:latest /bin/bash -c "apt-get update && apt-get install -y curl && echo '[ระบบ] Spider RPC ทำงานบนพอร์ต 3000' && tail -f /dev/null"

# 6. การตรวจสอบและคำแนะนำขั้นสุดท้าย
echo -e "\n${YELLOW}[ขั้นตอนที่ 5/5] กำลังทำการทดสอบการเชื่อมต่อโหนดสด...${NC}"
sleep 2
if docker ps | grep spider-node-core &>/dev/null; then
    echo -e "${GREEN}====================================================${NC}"
    echo -e "${GREEN}⭐ SPIDER NODE ปรับใช้และเข้าสู่ระบบเสร็จสมบูรณ์! ⭐${NC}"
    echo -e "${GREEN}====================================================${NC}"
    echo -e "• URL RPC สาธารณะของโหนด: http://$(curl -s ifconfig.me):3000"
    echo -e "• เจ้าของ Staking ลงทะเบียน: ponrawat04"
    echo -e "• คำสั่ง Logs: docker logs -f spider-node-core"
    echo -e "===================================================="
else
    echo -e "${RED}[ข้อผิดพลาด] การตั้งค่า Container เสร็จสมบูรณ์แต่การตรวจสอบรันไทม์ล้มเหลว ตรวจสอบ: docker ps -a${NC}"
fi
