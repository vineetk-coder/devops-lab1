import docker

# Create a Docker client
client = docker.from_env()

# Run the container with the AppArmor profile
container = client.containers.run(
    "flask-apparmor",
    ports={'5000/tcp': 5000},
    security_opt=["apparmor=my-apparmor-profile"],
    detach=True
)
print(f"Container started: {container.short_id}")

try:
    # Test restricted actions
    exit_code, output = container.exec_run("cat /etc/passwd")
    print(f"Attempt to read /etc/passwd: Exit Code {exit_code}, Output: {output.decode()}")

    exit_code, output = container.exec_run("/bin/bash")
    print(f"Attempt to execute /bin/bash: Exit Code {exit_code}, Output: {output.decode()}")

    # Control: Python itself (in /usr/local/bin) is allowed and /app is writable
    exit_code, output = container.exec_run(
        ["python", "-c", "open('/app/ok.txt','w').write('ok'); print(open('/app/ok.txt').read())"])
    print(f"Control - write/read inside /app: Exit Code {exit_code}, Output: {output.decode().strip()}")

    # Python trying to read /etc/passwd directly (no binary exec involved)
    exit_code, output = container.exec_run(["python", "-c", "print(open('/etc/passwd').read())"])
    print(f"Python read of /etc/passwd: Exit Code {exit_code}, Output: {output.decode().strip()[-80:]}")
finally:
    # Stop the container
    container.stop()
    container.remove()
    print("Container stopped")
