# Setup the  shell

Enter the desired host in the hosts file like this: 

    10.20.1.138	ansible_user=root	ansible_ssh_pass=<password>

Choose any user who is either root or has sudo rights.

After that set the username for whom the shell shell be setup inside pimp_shell.yml

    vars:
      username: <username>

Now run the plybook with the following command:

    ansible-playbook pimp_shell.yml
