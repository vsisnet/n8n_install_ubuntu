# n8n Installation and Upgrade Scripts for Ubuntu

This repository contains two Bash scripts to install and upgrade [n8n](https://n8n.io/), a powerful workflow automation tool, on an Ubuntu server using Docker and Docker Compose. The scripts also configure [Caddy](https://caddyserver.com/) as a reverse proxy for HTTPS access.

## English

### Prerequisites
- An Ubuntu server (18.04 or later recommended).
- Root or sudo privileges.
- A domain or subdomain with DNS records pointing to your server's public IP.
- Internet access for downloading Docker images and dependencies.

### Scripts

#### 1. `n8n_install_ubuntu.sh`
This script automates the installation of n8n on Ubuntu using Docker and Docker Compose. It also downloads the `upgrade_n8n.sh` script automatically for future upgrades.

##### Features
- Checks for root privileges.
- Verifies that the provided domain/subdomain points to the server's public IP.
- Installs Docker and Docker Compose.
- Creates a directory (`/home/n8n`) for n8n configuration and data.
- Sets up a `docker-compose.yml` file to run n8n and Caddy containers.
- Configures Caddy for automatic HTTPS with a reverse proxy to n8n.
- Downloads and sets up `upgrade_n8n.sh` in `/home/n8n` with executable permissions.
- Starts the containers in detached mode.

##### Usage
1. Download the script from GitHub:
   ```bash
   curl -O https://raw.githubusercontent.com/vsisnet/n8n_install_ubuntu/main/n8n_install_ubuntu.sh
   ```
   or
   ```bash
   wget https://raw.githubusercontent.com/vsisnet/n8n_install_ubuntu/main/n8n_install_ubuntu.sh
   ```
2. Make the script executable:
   ```bash
   chmod +x n8n_install_ubuntu.sh
   ```
3. Run the script with root privileges:
   ```bash
   sudo ./n8n_install_ubuntu.sh
   ```
4. Enter your domain/subdomain when prompted.
5. After successful installation, access n8n at `https://<your-domain>`.

##### Notes
- Ensure your domain's DNS (A record) points to your server's public IP before running the script.
- The script sets the timezone to `Asia/Ho_Chi_Minh`. Modify the `GENERIC_TIMEZONE` in `docker-compose.yml` if needed.
- Learn n8n basics at [vsis.net](https://vsis.net).

#### 2. `upgrade_n8n.sh`
This script upgrades an existing n8n installation to the latest version while preserving data. It is automatically downloaded by `n8n_install_ubuntu.sh` into `/home/n8n`.

##### Features
- Checks for root privileges and the existence of the n8n directory.
- Backs up the current n8n data (`/home/n8n/.n8n`) to a timestamped tar.gz file.
- Stops running containers.
- Pulls the latest `n8nio/n8n` and `caddy:2` images.
- Restarts the containers with the updated images.

##### Usage
1. The `upgrade_n8n.sh` script is already downloaded and set up by `n8n_install_ubuntu.sh` in `/home/n8n`.
2. Run the script with root privileges:
   ```bash
   sudo /home/n8n/upgrade_n8n.sh
   ```
3. Verify the upgrade by accessing `https://<your-domain>`.

##### Notes
- Backups are stored in `/home/n8n` with names like `n8n_backup_YYYYMMDD_HHMMSS.tar.gz`.
- To restore a backup, extract it to `/home/n8n/.n8n`:
   ```bash
   tar -xzf /home/n8n/n8n_backup_*.tar.gz -C /home/n8n/.n8n
   ```
- Ensure your domain still points to the server's IP before upgrading.

### Troubleshooting
- **Domain not pointing to server**: Verify DNS settings using `dig` or `nslookup`. Update the A record to your server's public IP.
- **Docker issues**: Check logs with:
  ```bash
  docker-compose -f /home/n8n/docker-compose.yml logs
  ```
- **Caddy HTTPS issues**: Ensure ports 80 and 443 are open and not blocked by a firewall.

### Contributing
Submit issues or pull requests for improvements to these scripts.

### License
This project is licensed under the MIT License.

---

## Tiếng Việt

# Script Cài Đặt và Nâng Cấp n8n cho Ubuntu

Kho lưu trữ này chứa hai script Bash để cài đặt và nâng cấp [n8n](https://n8n.io/), một công cụ tự động hóa quy trình mạnh mẽ, trên máy chủ Ubuntu sử dụng Docker và Docker Compose. Các script cũng cấu hình [Caddy](https://caddyserver.com/) làm reverse proxy để truy cập qua HTTPS.

### Yêu cầu
- Máy chủ Ubuntu (khuyến nghị 18.04 trở lên).
- Quyền root hoặc sudo.
- Tên miền hoặc tên miền phụ có bản ghi DNS trỏ đến IP công khai của máy chủ.
- Kết nối internet để tải image Docker và các phụ thuộc.

### Các Script

#### 1. `n8n_install_ubuntu.sh`
Script này tự động hóa việc cài đặt n8n trên Ubuntu bằng Docker và Docker Compose. Script cũng tự động tải script `upgrade_n8n.sh` để sử dụng cho việc nâng cấp sau này.

##### Tính năng
- Kiểm tra quyền root.
- Xác minh tên miền/tên miền phụ trỏ đúng đến IP công khai của máy chủ.
- Cài đặt Docker và Docker Compose.
- Tạo thư mục (`/home/n8n`) để lưu cấu hình và dữ liệu n8n.
- Thiết lập file `docker-compose.yml` để chạy các container n8n và Caddy.
- Cấu hình Caddy để tự động sử dụng HTTPS với reverse proxy tới n8n.
- Tải và thiết lập `upgrade_n8n.sh` trong `/home/n8n` với quyền thực thi.
- Khởi động các container ở chế độ nền.

##### Cách sử dụng
1. Tải script từ GitHub:
   ```bash
   curl -O https://raw.githubusercontent.com/vsisnet/n8n_install_ubuntu/main/n8n_install_ubuntu.sh
   ```
   hoặc
   ```bash
   wget https://raw.githubusercontent.com/vsisnet/n8n_install_ubuntu/main/n8n_install_ubuntu.sh
   ```
2. Phân quyền thực thi cho script:
   ```bash
   chmod +x n8n_install_ubuntu.sh
   ```
3. Chạy script với quyền root:
   ```bash
   sudo ./n8n_install_ubuntu.sh
   ```
4. Nhập tên miền/tên miền phụ khi được yêu cầu.
5. Sau khi cài đặt thành công, truy cập n8n tại `https://<your-domain>`.

##### Lưu ý
- Đảm bảo bản ghi DNS (A record) của tên miền trỏ đến IP công khai của máy chủ trước khi chạy script.
- Script đặt múi giờ là `Asia/Ho_Chi_Minh`. Sửa `GENERIC_TIMEZONE` trong `docker-compose.yml` nếu cần.
- Tìm hiểu cơ bản về n8n tại [vsis.net](https://vsis.net).

#### 2. `upgrade_n8n.sh`
Script này nâng cấp cài đặt n8n hiện có lên phiên bản mới nhất mà vẫn giữ nguyên dữ liệu. Script được tự động tải bởi `n8n_install_ubuntu.sh` và đặt trong `/home/n8n`.

##### Tính năng
- Kiểm tra quyền root và sự tồn tại của thư mục n8n.
- Sao lưu dữ liệu n8n hiện tại (`/home/n8n/.n8n`) vào file tar.gz có tên theo thời gian.
- Dừng các container đang chạy.
- Tải image mới nhất của `n8nio/n8n` và `caddy:2`.
- Khởi động lại các container với image đã cập nhật.

##### Cách sử dụng
1. Script `upgrade_n8n.sh` đã được tải và thiết metering lập bởi `n8n_install_ubuntu.sh` trong `/home/n8n`.
2. Chạy script với quyền root:
   ```bash
   sudo /home/n8n/upgrade_n8n.sh
   ```
3. Kiểm tra nâng cấp bằng cách truy cập `https://<your-domain>`.

##### Lưu ý
- Bản sao lưu được lưu trong `/home/n8n` với tên như `n8n_backup_YYYYMMDD_HHMMSS.tar.gz`.
- Để khôi phục bản sao lưu, giải nén vào `/home/n8n/.n8n`:
   ```bash
   tar -xzf /home/n8n/n8n_backup_*.tar.gz -C /home/n8n/.n8n
   ```
- Đảm bảo tên miền vẫn trỏ đến IP của máy chủ trước khi nâng cấp.

### Xử lý sự cố
- **Tên miền không trỏ đến máy chủ**: Kiểm tra cài đặt DNS bằng `dig` hoặc `nslookup`. Cập nhật bản ghi A tới IP công khai của máy chủ.
- **Sự cố Docker**: Kiểm tra log bằng:
  ```bash
  docker-compose -f /home/n8n/docker-compose.yml logs
  ```
- **Sự cố HTTPS của Caddy**: Đảm bảo cổng 80 và 443 mở và không bị chặn bởi tường lửa.

### Đóng góp
Hãy gửi issue hoặc pull request để cải thiện các script này.

### Giấy phép
Dự án này được cấp phép theo MIT License.