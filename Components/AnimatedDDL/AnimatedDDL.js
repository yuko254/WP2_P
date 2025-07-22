
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

        const customWrapper = document.createElement("div");
        customWrapper.classList.add("custom-dropdown");

        const trigger = document.createElement("div");
        trigger.classList.add("dropdown-trigger");

        const label = document.createElement("label");
        label.classList.add("dropdown-label");
        label.textContent = "dddd"

        const optionsList = document.createElement("ul");
        optionsList.classList.add("dropdown-options");

        customWrapper.appendChild(label);
        customWrapper.appendChild(trigger);
        customWrapper.appendChild(optionsList);

        sourceDDL.parentNode.insertBefore(customWrapper, sourceDDL.nextSibling);
        populateCustomDDL(sourceDDL, customWrapper);
    });

    document.querySelectorAll('.dropdown-trigger, .dropdown-options').forEach(trigger => {
        trigger.addEventListener('mouseenter', () => {
            const label = trigger.closest('.custom-dropdown')?.querySelector('.dropdown-label');
            if (label && label.classList.contains('dropdown-label')) {
                label.style.transform = 'translateY(-50%) scale(0.8)';
                label.style.padding = '0 .2em';
                label.style.backgroundColor = 'white';
            }
        });

        trigger.addEventListener('mouseleave', () => {
            const label = trigger.previousElementSibling;
            if (label && label.classList.contains('dropdown-label')) {
                label.style.transform = '';
                label.style.padding = '';
                label.style.backgroundColor = '';
            }
        });
    });
});

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
            targetDDL.classList.add('dropdown-suppressed');
            setTimeout(() => {
                targetDDL.classList.remove('dropdown-suppressed');
            }, 500);
        });

        optionsList.appendChild(li);
    });
};