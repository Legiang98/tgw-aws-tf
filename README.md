# Network Stack Overview

The isolated network model is illustrated in the attached PNG image (tgw_inspection.drawio.png)

## Key Features

- **Network Isolation:**  
  All inbound and outbound traffic is routed through a dedicated network appliance (such as AWS Network Firewall or a custom appliance). This ensures that only authorized traffic enters or leaves the VPC.

- **Layered Design:**  
  - **Layer 0 (Networking):**  
    Sets up VPCs, subnets, route tables, security groups, network ACLs, and the network appliance.
  - **Layer 1 (Computing):**  
    Deploys EC2 instances and related compute resources.

- **Modular Structure:**  
  Reusable Terraform modules for VPC, subnets, NAT, IGW, network firewall, security groups, and more.

## How It Works

- **Inbound Traffic:**  
  All incoming traffic is inspected and filtered by the network appliance before reaching internal resources.
- **Outbound Traffic:**  
  Outbound connections from workloads are also routed through the appliance, allowing for logging, filtering, and policy enforcement.

## Getting Started

1. Clone the repository.
2. Configure your backend and variables in the `config/` and `vars/` folders.
3. All the configurations and values are stored in the tfvars file
4. You should implement each layer by their order (network -> compute)
5. Testing: you should provision VMs and then try to the Session mamager in AWS to test the network connection between VMs

## Security Benefits

- Centralized control of network flows.
- Enhanced visibility and logging.
- Simplified compliance with security policies.
