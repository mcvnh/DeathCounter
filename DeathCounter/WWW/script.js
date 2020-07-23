(function () {
  const searchParams = (new URL(window.location.href)).searchParams;
  const birthday = new Date(searchParams.get('birthday'));
  const expectedDeathDay = new Date(
    birthday.getFullYear() + parseInt(searchParams.get('expectedDeathAge')),
    birthday.getMonth(),
    birthday.getDate()
  );

  setInterval(() => {
    const currentDay = new Date();

    let remains = expectedDeathDay - currentDay;
    const remainDays = parseInt(remains / (1000 * 60 * 60 * 24));

    remains -= remainDays * (1000 * 60 * 60 * 24);
    const remainHours = parseInt(remains / (1000 * 60 * 60));

    remains -= remainHours * (1000 * 60 * 60);
    const remainMinutes = parseInt(remains / (1000 * 60));

    remains -= remainMinutes * (1000 * 60);
    const remainSeconds = parseInt(remains / 1000);

    let partials = [
      remainDays ? { name: 'days', value: remainDays } : undefined,
      { name: 'hours', value: remainHours },
      { name: 'minutes', value: remainMinutes },
      { name: 'seconds', value: remainSeconds }
    ].filter(Boolean);
    
    if (!remainDays && !remainHours && !remainMinutes && !remainSeconds) {
      partials = [];
    }
    
    const $container = document.querySelector('.partials-container');
    $container.innerHTML = '';
    
    // TODO: You die
    partials.forEach(partial => {
      const $element = document.createElement('div');
      $element.innerHTML = `
        <div class="value">${ (partial.value < 10 ? '0' : '') + partial.value }</div>
        <div class="name">${ partial.name }</div>
      `
      $element.className = 'partial';
      $container.appendChild($element);
    });
  }, 1000)
})()
