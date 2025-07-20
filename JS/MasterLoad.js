function staggerLoad(options, baseDelay = 500, step = 100) {
    options.forEach((option, index) => {
        requestAnimationFrame(() => {
            setTimeout(() => {
                option.classList.add("loaded");
            }, baseDelay + index * step);
        });
    });
};

window.onload = function handleload() {
    document.querySelector(".main-content").classList.add("loaded");
    document.querySelector(".sidebar").classList.add("loaded");
    document.querySelector(".sidebar-top").classList.add("loaded");
    document.body.classList.add("dom-loaded");

    let sidebar_options = document.querySelectorAll(".sidebar-menu-option");
    let main_content_options = document.querySelectorAll("fieldset");
    staggerLoad(sidebar_options);
    staggerLoad(main_content_options,800,200);
};