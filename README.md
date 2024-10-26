# Docker Development Environment for Interactive Web Application

This repository provides a Dockerized development environment designed for building a responsive and interactive web application. Equipped with modern tools and libraries like Node.js, React, Three.js, and NeoVim, this setup is tailored for developing applications with rich UIs and 3D graphics.

## 🛠 Key Features

- **React and Shadcn UI**: for building modular and responsive UI components.
- **Three.js**: integration for immersive 3D graphics and animations.
- **Tailwind CSS**: for efficient and customizable styling across the application.
- **Express.js**: for managing server-side routing and backend API handling.
- **NeoVim**: with autocompletion, Git integration, and code folding for an optimized coding experience.
- **Automated Testing**: with Jest for unit and integration tests.
- **ESLint and Prettier**: for maintaining code quality and consistent formatting.
- **CI/CD-ready**: Docker setup that supports scalable development and deployment workflows.

## 🚀 Installation and Setup

### Prerequisites

- **Docker** and **Docker Compose** must be installed on your machine.

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/docker-development-env.git
   cd docker-development-env

2. **Run Docker with the update script**:

    This command will ensure your Docker container is up-to-date and starts the development environment.
    ```bash
    ./docker-update.sh

## 📄 Useful Commands
- **Enter the container**:
    ```bash
    docker exec -it your_service_name /bin/bash
- **Use NeoVim in the container**:
    ```bash
    docker-compose run neovim
- **Run tests**:

    Inside the Docker container, execute:
    ```bash
    npm test
- **Lint and format code**:

    To check and format code with ESLint and Prettier:
    ```bash
    npm run lint
    npm run format

## 📖 Documentation and Wiki
For a comprehensive guide on setup, usage, and contributing to this project, please refer to the [Project Wiki](https://github.com/Gregory-Marquiset/docker_env_gmarquis/wiki). The Wiki contains information on:

- **Detailed Setup**: Step-by-step instructions to configure your environment.
- **Using NeoVim**: Configuration and plugins for a seamless coding experience.
- **Testing and Automation**: Guidelines for running tests and maintaining code quality.
- **Deployment Guide**: Instructions for deploying the application with CI/CD pipelines.

### 📂 Project Structure
- **Dockerfile**: Defines the Docker image and installs necessary dependencies.
- **docker-compose.yml**: Manages Docker services, including NeoVim and Node.js.
- **init.vim**: Configuration for NeoVim, including plugins for development.
- **clone-repo.sh**: Script to clone or mount the Git repository for collaborative development.

### 📦 Technologies Used
- **Docker, Docker Compose**: Core containerization tools to ensure a portable and consistent development environment.
- **Node.js and Express.js**: Backend development and API management.
- **React and Shadcn UI**: Frontend development for building responsive and modular UI components.
- **Three.js**: 3D graphics library for adding interactive and immersive visual elements.
- **Tailwind CSS**: Utility-first CSS framework for efficient styling.
- **NeoVim**: Enhanced text editor with autocompletion and Git integration.
- **Jest**: Testing framework for unit and integration tests.
- **ESLint and Prettier**: Tools for code quality and consistent formatting.

## 🤝 Contributing
Contributions are welcome! Please see the [Contribution Guide](https://github.com/Gregory-Marquiset/docker_env_gmarquis/wiki/Contribution-Guide) in the Wiki for more information on contributing to this project.
___
With this structured Docker environment, my goal is to streamline the development workflow and maintain a high standard of code quality, ensuring a smooth experience from development to deployment.

For further assistance, explore the project [Wiki](https://github.com/Gregory-Marquiset/docker_env_gmarquis/wiki).