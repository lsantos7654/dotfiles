# Use the base ROS Humble Desktop image
FROM osrf/ros:humble-desktop

# Create the user and add to sudoers
RUN useradd -m -s /bin/bash santos && \
    echo 'santos ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Switch to the new user
USER santos
WORKDIR /home/santos

# Set the default command
# CMD ["bash"]

