-- LuaRocks configuration

rocks_trees = {
   { name = "user", root = home .. "/.luarocks" };
   { name = "system", root = "/home/diogo/Desktop/renato-collab/shared_mem_setup/wrkdir/srcs/linux_VM/buildroot-aarch64-v6.1/output/host" };
}
lua_interpreter = "lua";
variables = {
   LUA_DIR = "/home/diogo/Desktop/renato-collab/shared_mem_setup/wrkdir/srcs/linux_VM/buildroot-aarch64-v6.1/output/host";
   LUA_BINDIR = "/home/diogo/Desktop/renato-collab/shared_mem_setup/wrkdir/srcs/linux_VM/buildroot-aarch64-v6.1/output/host/bin";
}
