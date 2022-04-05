$(document).on ("turbolinks:load", function(){
  // document.addEventListener('click',function(e){
    // var t=e.target;
    // if(t.id=="speak-btn"){
    //   const a =Array.prototype.map.call(t.parentNode.parentNode.querySelectorAll('td'),function(n){
    //     const text = n.textContent;
    //   }).filter(function(v){
    //     return v!=="";
    //   })
    // };

  const text        = document.querySelector('#detail')
  const voiceSelect = document.querySelector('#voice-select')
  const speakBtn    = document.querySelector('#speak-btn')
  const stopBtn    = document.querySelector('#stop-btn')

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
  
  speakBtn.addEventListener('click', function() {
    const uttr = new SpeechSynthesisUtterance(text.value)
    uttr.voice = speechSynthesis
      .getVoices()
      .filter(voice => voice.name === voiceSelect.value)[0]
    speechSynthesis.speak(uttr)
  })

  stopBtn.addEventListener('click', function(){
    speechSynthesis.cancel();
  }, false);
});