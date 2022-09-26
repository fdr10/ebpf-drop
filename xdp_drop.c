#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>
#include <linux/if_ether.h>
#include <arpa/inet.h>


SEC("xdp_drop")
int xdp_drop_prog(struct xdp_md *ctx){
   return XDP_DROP;
}
SEC("xdp_pass")
int xdp_pass_prog(struct xdp_md *ctx){
   return XDP_DROP;
}

char _license[] SEC("license") ="GPL";
