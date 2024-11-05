document.addEventListener('DOMContentLoaded', function () {
    const transitionLinks = document.querySelectorAll('.transition-link');
    transitionLinks.forEach(link => {
        link.addEventListener('click', function (event) {
            event.preventDefault();
            const transitionImage = this.dataset.transition;
            playTransition(transitionImage);
            setTimeout(() => {
                window.location.href = this.href;
            }, 1993); // Change the time (in milliseconds) as needed
        });
    });

    function playTransition(transitionImage) {
        document.body.style.backgroundImage = `url('${transitionImage}')`;
    }
});