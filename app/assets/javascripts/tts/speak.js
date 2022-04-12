$(document).on ("turbolinks:load", function(){

  const voiceSelect = document.querySelector('#voice-select')

  function appendVoices() {
    const voices = speechSynthesis.getVoices()
    voiceSelect.innerHTML = ''
    // for(i = 0; i < voices.length ; i++) {
    //   var option = document.createElement('option');
    //   option.textContent = voices[i].name + ' (' + voices[i].lang + ')';
    
    //   if(voices[i].default) {
    //     option.textContent += ' -- DEFAULT';
    //   }
    
    //   option.setAttribute('data-lang', voices[i].lang);
    //   option.setAttribute('data-name', voices[i].name);

    voices.forEach(voice => {
      if(!voice.lang.match('ja|en-US')) return
      const option = document.createElement('option')
      option.value = voice.name
      option.text  = `${voice.name} (${voice.lang})`
      option.setAttribute('selected', voice.default)
      voiceSelect.appendChild(option)
    });
  }
  
  appendVoices()
  speechSynthesis.onvoiceschanged = e => {
    appendVoices()
  }
  
  $('.speak-btn').on('click', function() {
    const uttr = new SpeechSynthesisUtterance(this.getAttribute('data-blog'))
    uttr.voice = speechSynthesis
      .getVoices()
      .filter(voice => voice.name === voiceSelect.value)[0]
    speechSynthesis.speak(uttr)
  })

  $('.pause-btn').on('click', function(){
    speechSynthesis.pause();
  })

  $('.resume-btn').on('click', function(){
    speechSynthesis.resume();
  })

  $('.stop-btn').on('click', function(){
    speechSynthesis.cancel();
  })
});