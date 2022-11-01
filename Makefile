.PHONY: veth-pair
veth-pair:
	sudo ip netns add ns01
	sudo ip link add name eth0 netns ns01 type veth  peer name eth0  
	sudo ip netns exec ns01 ip addr add 10.0.0.0/32 dev eth0
	sudo ip addr add 10.0.0.1/32 dev eth0
	sudo ip netns exec ns01 ip link set eth0 up
	sudo ip netns exec ns01 ip link set lo up
	sudo ip link set eth0 up
	sudo ip netns exec ns01 ip route add 10.0.0.1/32 dev eth0
	sudo ip route add 10.0.0.0/32 dev eth0
	
.PHONY: ebpf-simple-drop 
ebpf-simple-drop:
	@clang -O2 -g -Wall -target bpf -c xdp_drop.c -o xdp_drop.o


.PHONY: load-xdp
load-xdp: ebpf-simple-drop
	@sudo xdp-loader load -m skb -s xdp_drop eth0 xdp_drop.o


.PHONY: unload-xdp
unload-xdp: 
	@sudo ip link set eth0 xdpgeneric off


.PHONY: clean
clean:
	sudo ip netns del ns01 

