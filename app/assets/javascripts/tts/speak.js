$(document).on ("turbolinks:load", function(){

  const voiceSelect = document.querySelector('#voice-select')

  function appendVoices() {
    const voices = speechSynthesis.getVoices()
    voiceSelect.innerHTML = ''
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

  $('.stop-btn').on('click', function(){
    speechSynthesis.cancel();
  }, false);
});