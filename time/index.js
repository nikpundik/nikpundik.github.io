window.onload = () => {
  const hoursCircle = document.querySelector(".hours");
  const minutesCircle = document.querySelector(".minutes");

  const updateClock = () => {
    const now = new Date();
    const hours = now.getHours() % 12;
    const minutes = now.getMinutes();
    const seconds = now.getSeconds();
    const milliseconds = now.getMilliseconds();

    const totalMinutes = minutes * 60 + seconds + milliseconds / 1000;
    const totalHours = hours * 3600 + totalMinutes;

    const hoursRotation = -(360 / (12 * 3600)) * totalHours;
    const minutesRotation = -(360 / 3600) * totalMinutes;

    hoursCircle.style.transform = `rotate3d(0, 0, 1, ${hoursRotation}deg)`;
    minutesCircle.style.transform = `rotate3d(0, 0, 1, ${minutesRotation}deg)`;

    requestAnimationFrame(updateClock);
  };

  requestAnimationFrame(updateClock);
};
