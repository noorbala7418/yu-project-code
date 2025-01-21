

```yaml

haproxy_configs:
  - name: kwc-kubernetes-http
    frontend:
      bind: 0.0.0.0:80
    backend:
      mode: tcp
      check_settings:
        option: tcp-check
        interval: 2s
      balance: roundrobin
      servers:
        - name: node-0
          ip: 192.168.50.40
          port: 80
          weight: 1
        - name: node-1
          ip: 192.168.50.41
          port: 80
          weight: 1
        - name: node-2
          ip: 192.168.50.42
          port: 80
          weight: 1
        - name: node-3
          ip: 192.168.50.43
          port: 80
          weight: 1
      backup_servers: []
```
