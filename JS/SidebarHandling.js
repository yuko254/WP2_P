let sidebar_options = document.querySelectorAll(".sidebar-menu-option-btn");
var clicked_option = document.querySelector(".sidebar-menu-option-btn.sidebar-menu-option-clicked")
sidebar_options.forEach(option => {
    option.addEventListener("click", event => {
        if (clicked_option)
            clicked_option.classList.remove("sidebar-menu-option-clicked");
        clicked_option = event.target;
        clicked_option.classList.add("sidebar-menu-option-clicked");

        // trigger a custom event
        document.dispatchEvent(new CustomEvent("NavOptionClicked", {
            detail: { id: window.clicked_option.id }
        }));
    });
});

const panelElements = Array.from(document.querySelectorAll('.main-content *'))
    .filter(el => /pnl\d+$/.test(el.id)) // Match IDs ending in pnl followed by digits
    .sort((a, b) => {
        const numA = parseInt(a.id.match(/pnl(\d+)$/)[1]); // extract number after 'pnl'
        const numB = parseInt(b.id.match(/pnl(\d+)$/)[1]);
        return numA - numB;
    });

document.addEventListener("NavOptionClicked", e => {
    const id = e.detail.id;
    panelElements.forEach(panel => {
        if (panel) {
            panel.style.display = 'none';
        }
    });
    if (panelElements[id - 1])
        panelElements[id - 1].style.display = 'block';
});
