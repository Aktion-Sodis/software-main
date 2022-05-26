const NavbarAtributes = {
    state: () => ({
        SideBarCollapsed: false,
        SidebarWidth: "260px",
        SidebarWidthCollapsed: "70px",
        SidebarWidthExpanded: "260px"
    }),
    mutations: {
        toggleSidebar (state) {
            if ( state.SideBarCollapsed) {
                state.SidebarWidth = state.SidebarWidthExpanded
            } else {
                state.SidebarWidth = state.SidebarWidthCollapsed
            }
            state.SideBarCollapsed = !state.SideBarCollapsed
            console.log(state.SidebarWidth)
        },
    },
}

export default NavbarAtributes;