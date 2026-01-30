# IrfanView 4.73 (64-bit) – Intune Win32 Deployment

This repository contains a **production-ready Microsoft Intune Win32 package** for deploying **IrfanView 4.73 (64-bit)** including **official plugins**, using **bundled offline installers**.

The solution avoids:
- Microsoft Store
- winget
- Internet dependency during installation
- User-context installs

It is designed for **SYSTEM-context**, **Company Portal**, and **enterprise environments**.

---

## 📦 Package Overview

- **Application:** IrfanView 4.73 (64-bit)
- **Publisher:** Irfan Skiljan
- **Deployment Type:** Intune Win32
- **Install Context:** SYSTEM
- **Install Mode:** Silent
- **Plugins:** Included
- **Status:** Tested & Working

---

## 📁 Folder Structure

IrfanView_Win32/
├─ install.ps1
├─ uninstall.ps1
├─ iview473g_x64_setup.exe
└─ iview473_plugins_x64_setup.exe
