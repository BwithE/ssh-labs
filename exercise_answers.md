## Exercise answers

---

### Task 1 - Local Port Forward
- On box1, create a local port forward using port 7654 that tunnels through box2 and redirects to box3 on port 7654.

Connect to box1
```
ssh -p 2222 slacker@127.0.0.1
```

Create the localport forward
```
slacker@box1:~$ ssh -L 7654:10.10.10.30:7654 slacker@172.16.200.20
slacker@172.16.200.20's password:

slacker@box2:~$
```

- Once you've done that, netcat your localhost at 7654 to receive the flag.
```
slacker@box1:~$ nc 127.0.0.1 7654
FLAG_TASK_1
```

---
### Task 2 - Remote Port Forward
- From box1, create a remote port forward on box2, utilizing port 9999 that will redirect traffic back to your local port of 4444.
```
slacker@box1:~$ ssh -R 9999:172.16.200.10:4444 slacker@172.16.200.20
slacker@172.16.200.20's password:

slacker@box2:~$
```

- Once you've done that, start a netcat listener on port 4444 to receive the flag.
```
slacker@box1:~$ nc -nvlp 4444
Listening on 0.0.0.0 4444
Connection received on 172.16.200.10 39706
FLAG_TASK_2
```

---

### Task 3 - Multi-Hop Pivot to box4
- Starting on box1, create a local port forward using port 4444 that will tunnel through box2 and redirect to box3 on port 22.
```
slacker@box1:~$ ssh -L 4444:10.10.10.30:22 slacker@172.16.200.20
slacker@172.16.200.20's password:

slacker@box2:~$
```

- Then, using that same local port forward tunnel, create another local port forward using port 5555 that will tunnel through box3 and redirect to box4 on port 12345.
```
slacker@box1:~$ ssh -L 5555:10.20.20.40:12345 -p 4444 slacker@127.0.0.1
slacker@127.0.0.1's password:

slacker@box3:~$
```

- Once you've stood up your tunnels, on box1, netcat the localhost at 5555 to receive the flag.
```
slacker@box1:~$ nc 127.0.0.1 5555
FLAG_TASK_3
```
