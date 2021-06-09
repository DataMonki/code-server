# Start from the code-server Debian base image
FROM codercom/code-server:latest 

USER coder

# Apply VS Code settings
COPY deploy-container/settings.json .local/share/code-server/User/settings.json

# Use bash shell
ENV SHELL=/bin/bash

# Install unzip + rclone (support for remote filesystem)
RUN sudo apt-get update && sudo apt-get install unzip -y
RUN curl https://rclone.org/install.sh | sudo bash

# You can add custom software and dependencies for your environment here. Some examples:
RUN sudo apt-get install wget build-essential libssl-dev libffi-dev python3-dev -y
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
RUN echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
#RUN cd ~/powerlevel10k
#RUN exec zsh

# RUN code-server --install-extension esbenp.prettier-vscode
RUN sudo apt-get install -y build-essential
RUN sudo apt-get install zsh
# RUN COPY myTool /home/coder/myTool

# Fix permissions for code-server
#RUN sudo chown -R coder:coder /home/coder/.local

# Port
ENV PORT=8080

# Use our custom entrypoint script first
COPY deploy-container/entrypoint.sh /usr/bin/deploy-container-entrypoint.sh
ENTRYPOINT ["/usr/bin/deploy-container-entrypoint.sh"]
