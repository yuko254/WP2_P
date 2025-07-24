
/*
    to use this simply your ASP:DDL MUST have an ID that ends with DDL then
    just import with script src to your page
        <script src="/Components/AnimatedDDL/replaceDDLsWithAnimatedDDLs.js"></script>

    **Note** 
    dont forget adding the styles if theyre not added in the master
    (in this case they are in site1.master)
        <link href="/Components/AnimatedDDL/AnimatedDDL.css" rel="stylesheet" type="text/css" />
 */

window.addEventListener("DOMContentLoaded", () => {
    const sourceDDLs = Array.from(document.querySelectorAll(".main-content *")).filter(el => /DDL$/.test(el.id));
    sourceDDLs.forEach(sourceDDL => {
        sourceDDL.style.display = "none";
        sourceDDL.value = "";

        const customWrapper = document.createElement("div");
        customWrapper.classList.add("custom-dropdown");

        const trigger = document.createElement("div");
        trigger.classList.add("dropdown-trigger");

        const label = document.createElement("label");
        label.classList.add("dropdown-label");
        label.textContent = sourceDDL.dataset.name;

        const optionsList = document.createElement("ul");
        optionsList.classList.add("dropdown-options");

        customWrapper.appendChild(label);
        customWrapper.appendChild(trigger);
        customWrapper.appendChild(optionsList);
        sourceDDL.parentNode.insertBefore(customWrapper, sourceDDL.nextSibling);

        populateCustomDDL(sourceDDL, customWrapper);
    });

    document.querySelectorAll("fieldset").forEach(form => {
        form.querySelectorAll(".custom-dropdown").forEach(dropdown => {
            const trigger = dropdown.querySelector(".dropdown-trigger");
            const options = dropdown.querySelector(".dropdown-options");
            const label = dropdown.querySelector(".dropdown-label");

            const activate = () => {
                form.querySelectorAll(".custom-dropdown").forEach(d => {
                    d.classList.remove("active");
                });
                dropdown.classList.add("active");
                label?.classList.add("label-hover");
            };

            const deactivate = () => {
                dropdown.classList.remove("active");
                if (trigger.textContent === "") {
                    label?.classList.remove("label-hover");
                }
            };

            trigger.addEventListener("mouseenter", activate);
            options.addEventListener("mouseenter", activate);

            dropdown.addEventListener("mouseleave", deactivate);
        });
    });
});

function populateCustomDDL(sourceDDL, targetDDL) {
    const trigger = targetDDL.querySelector(".dropdown-trigger");
    trigger.sourceDDL = sourceDDL;
    const optionsList = targetDDL.querySelector(".dropdown-options");

    Array.from(sourceDDL.options).forEach(opt => {
        const li = document.createElement("li");
        li.textContent = opt.text;
        li.dataset.value = opt.value;

        li.addEventListener("click", (e) => {
            trigger.textContent = opt.text + " ▼";
            sourceDDL.value = opt.value;
            sourceDDL.dispatchEvent(new Event("change"));
            targetDDL.classList.add('dropdown-suppressed');
            setTimeout(() => {
                targetDDL.classList.remove('dropdown-suppressed');
            }, 500);
        });

        optionsList.appendChild(li);
    });
};

function disableDDLs(form) {
    !form.classList.contains("form-disabled") && form.classList.add("form-disabled");
    form.dispatchEvent(new CustomEvent("toggled!"));
    form.querySelectorAll(".custom-dropdown").forEach(dropdown => {
        !dropdown.classList.contains("disabled") && dropdown.classList.add("disabled");
        const trigger = dropdown.querySelector(".dropdown-trigger");
        if (trigger?.sourceDDL) {
            trigger.textContent = "";
            trigger.sourceDDL.value = "";
        }
    });
};

function toggleDDLs(form, disabled) {
    form.querySelectorAll(".custom-dropdown").forEach(dropdown => {
        dropdown.classList.toggle("disabled", disabled);
        const trigger = dropdown.querySelector(".dropdown-trigger");
        if (trigger?.sourceDDL) {
            trigger.textContent = "";
            trigger.sourceDDL.value = "";
        }
    });
};