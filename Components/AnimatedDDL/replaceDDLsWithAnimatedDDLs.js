
/*
    to use this simply your ASP:DDL MUST have an ID that ends with DDL then
    just import with script src to your page
        <script src="/Components/AnimatedDDL/replaceDDLsWithAnimatedDDLs.js"></script>

    **Note** 
    dont forget adding the styles if theyre not added in the master
    (in this case they are in site1.master)
        <link href="/Components/AnimatedDDL/AnimatedDDL.css" rel="stylesheet" type="text/css" />
 */

function populateCustomDDL(sourceDDL, targetDDL) {
    const trigger = targetDDL.querySelector(".dropdown-trigger");
    const optionsList = targetDDL.querySelector(".dropdown-options");

    Array.from(sourceDDL.options).forEach(opt => {
        const li = document.createElement("li");
        li.textContent = opt.text;
        li.dataset.value = opt.value;

        li.addEventListener("click", (e) => {
            if (e.detail && e.detail.canceled) {
                trigger.textContent = "Choose option ▼";
                sourceDDL.value = "";
                return;
            }
            trigger.textContent = opt.text + " ▼";
            sourceDDL.value = opt.value;
            sourceDDL.dispatchEvent(new Event("change"));
            targetDDL.style.pointerEvents = "none";
            setTimeout(() => {
                targetDDL.style.pointerEvents = "auto";
            }, 500);
        });

        optionsList.appendChild(li);
    });
};

window.addEventListener("DOMContentLoaded", () => {
    const sourceDDLs = Array.from(document.querySelectorAll(".main-content *")).filter(el => /DDL$/.test(el.id));
    sourceDDLs.forEach(sourceDDL => {
        sourceDDL.style.display = "none";

        const customWrapper = document.createElement("div");
        customWrapper.classList.add("custom-dropdown");
        customWrapper.classList.add("input-group");

        const trigger = document.createElement("label");
        trigger.classList.add("dropdown-trigger");
        trigger.classList.add("dropdown-label");
        trigger.textContent = "Choose option ▼";

        const optionsList = document.createElement("ul");
        optionsList.classList.add("dropdown-options");
        optionsList.classList.add("dropdown-options-list");

        customWrapper.appendChild(trigger);
        customWrapper.appendChild(optionsList);

        sourceDDL.parentNode.insertBefore(customWrapper, sourceDDL.nextSibling);
        populateCustomDDL(sourceDDL, customWrapper);
    });
});