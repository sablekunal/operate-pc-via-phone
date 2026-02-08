<div align="center">
  <img src="https://www.spacedesk.net/wp-content/uploads/spacedesk-logo.svg" height="60" alt="Spacedesk Logo"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://raw.githubusercontent.com/dkaser/unraid-tailscale/main/logo.png" height="60" alt="Tailscale Logo"/>
</div>

# Operate PC via Android (Spacedesk + Tailscale)

This project provides a simple and effective way to turn your Android device into a second monitor or a touch-screen controller for your Windows PC, accessible from anywhere in the world.

## 🚀 How It Works

We use two powerful tools to achieve this:

1.  **[Spacedesk](https://www.spacedesk.net/)**:
    -   **Role**: Turns your Android device into a secondary display for your Windows PC.
    -   **Features**: Drag windows to your phone, use touch to click/scroll (KVM), and mirror your screen.
    -   **Requirement**: Both devices usually need to be on the *same network*.

2.  **[Tailscale](https://tailscale.com/)**:
    -   **Role**: Creates a secure "virtual" network (VPN) between your devices.
    -   **Benefit**: This tricks Spacedesk into thinking your devices are on the same local network, even if you are miles away (using mobile data or different Wi-Fi).

---

## 📋 Prerequisites

-   **Primary Device**: Windows 10/11 PC.
-   **Secondary Device**: Android Phone or Tablet.
-   **Internet Connection**: Both devices must be online.

---

## 🛠️ Installation Guide

### Step 1: Install on Windows PC

You can use our automated script or install manually.

**Option A: Automated Script (Recommended)**
1.  Open PowerShell as Administrator.
2.  Navigate to the `scripts` folder in this project:
    ```powershell
    cd scripts
    .\install_tools.ps1
    ```
3.  Follow the prompts to install Spacedesk Driver and Tailscale.
4.  **Reboot your PC** after installation is complete.

**Option B: Manual Installation**
1.  **Spacedesk Driver**: Download from the [official website](https://www.spacedesk.net/#download) and install.
2.  **Tailscale**: Download from the [official website](https://tailscale.com/download) and install. Log in with your account.

### Step 2: Install on Android

1.  Go to the **Google Play Store**.
2.  Install **[Spacedesk (remote display)](https://play.google.com/store/apps/details?id=ph.spacedesk.beta)**.
3.  Install **[Tailscale](https://play.google.com/store/apps/details?id=com.tailscale.ipn)**.
4.  Open **Tailscale** on Android and log in with the *same account* you used on your PC.
5.  activate the connection by toggle the "Active" switch in the top left corner.

---

## 🔗 Connection Guide

### Scenario A: Home Network (Local Wi-Fi)
>here no need of tailscale in android or pc

*Used when both devices are connected to the same Wi-Fi router.*

1.  Open the **Spacedesk App** on your Android.
2.  It should automatically detect your PC. Tap **Connect**.
3.  If not discovered:
    -   Run `.\scripts\connection_info.ps1` on your PC to see your **Local IP**.
    -   In the Android app, tap **(+)** and enter that IP.

### Scenario B: Remote Connection (Anywhere in the World)
>here comes the role of tailscale in android and pc to connect them virtually ( just think it like port forwarding but it is not )

*Used when your PC is at home and you are away (on 4G/5G or different Wi-Fi).*

1.  **On PC**: Ensure Tailscale is running and connected.
2.  **On Android**: Open Tailscale app and ensure "Active" is toggled **ON**.
3.  **Get Tailscale IP**:
    -   Run `.\scripts\connection_info.ps1` on your PC.
    -   Look for the **Tailscale IP** (starts with `100.x.x.x`).
4.  **Connect**:
    -   Open **Spacedesk App** on Android.
    -   Tap the **(+)** button (Manual Connect).
    -   Enter the **Tailscale IP** of your PC.
    -   Tap **Connect**.

---

## ❓ Troubleshooting

-   **"Server not found"**:
    -   Check if the Spacedesk Driver connects are "ON" in the Spacedesk Driver Console on your PC.
    -   Ensure Windows Firewall is strictly allowing "spacedeskService" and "Tailscale".
-   **Laggy Connection**:
    -   Lower the resolution/quality in the Spacedesk Viewer settings on your Android device.
    -   Remote connections depend heavily on upload speed at home and download speed on mobile.
-   **Touch not working**:
    -   Ensure "Touchscreen (absolute)" is enabled in Spacedesk Viewer settings.
-   **Keyboard/Mouse not working**:
    -   **CRITICAL**: You **MUST** enable "Password Protection & Encryption" in the Spacedesk Driver Console on your PC.
    -   Open **Spacedesk Driver Console** -> **Control** -> Check **"Password Protection"** -> There are pre setted password (we cannot manually set it, just can shuffle it )
    -   Use this password when connecting from your phone.


---

## 📂 Project Structure

-   `README.md`: This guide.
-   `scripts/install_tools.ps1`: Script to install required software.
-   `scripts/connection_info.ps1`: Helper script to find your connection IP.

--- 

## 👨‍💻 Developers Note

- we can use [rustdesk](https://rustdesk.com/) instead of spacedesk but it requires otp everytime you connect