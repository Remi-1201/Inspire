document.addEventListener('DOMContentLoaded', () => {
  var Rec=function(control,micOnBtn,recStartBtn,recStopBtn,recMime){
    this.control=control;
    this.micOnBtn   =micOnBtn;
    this.recStartBtn=recStartBtn;
    this.recStopBtn =recStopBtn;
    this.recMime = recMime;
    
    this.stream=null;
    this.mediaRecorder=null;
    this.chunks=[];
    this.recStartBtn.setAttribute("disabled",true);
    this.recStopBtn.setAttribute("disabled",true);
    this.type=null;
    
    this.micOnBtn.addEventListener("click",function(){
      if(navigator.mediaDevices==undefined){
        alert('Your browser does not support this function or you are not connected to the internet.');
        return;
      }
      navigator.mediaDevices.getUserMedia({audio:true})
      .then(function(stream){
        this.stream=stream;
        
        this.mediaRecorder=new MediaRecorder(this.stream);
        this.mediaRecorder.addEventListener("dataavailable",function(event){
          this.chunks.push(event.data);
          console.log(event.data);
        }.bind(this));
        this.mediaRecorder.addEventListener("stop",function(e){
          this.type=this.chunks[0].type;
          this.recMime.innerHTML=this.type;
          let blob=new Blob(this.chunks,{"type":this.type});
          this.chunks=[];
  
          let fileReaderAudio=new FileReader();
          fileReaderAudio.addEventListener("load",function(event){
            let audio_play=document.body.querySelector("#audio_play");
            if(audio_play==null){
              audio_play=document.createElement("audio");
              audio_play.setAttribute("controls","true");
              audio_play.setAttribute("id","audio_play");
              audio_play.setAttribute("playsinline","");
              this.control.appendChild(audio_play);
            }else{
              audio_play.pause();
              audio_play.currentTime=0;
            }
            audio_play.setAttribute("src",event.target.result);
            audio_play.load();
            audio_play.play();
          }.bind(this));
          fileReaderAudio.readAsDataURL(blob);
  
          this.recStartBtn.removeAttribute("disabled");
          this.recStopBtn.setAttribute("disabled",true);
        }.bind(this));
        this.recStartBtn.removeAttribute("disabled");
        this.micOnBtn.setAttribute("disabled",true);
      }.bind(this)).catch(function(e){
        console.log(e);
        document.getElementById("alert").innerHTML=e;
      }.bind(this));
    }.bind(this));
    this.recStartBtn.addEventListener("click",function(){
      this.recStartBtn.setAttribute("disabled", true);
      this.recStopBtn.removeAttribute("disabled");
      this.mediaRecorder.start();
    }.bind(this));    
    this.recStopBtn.addEventListener("click",function(){
      this.mediaRecorder.stop();
    }.bind(this));
  }
  window.addEventListener("DOMContentLoaded",function(){
    mamMicRec=new Rec(
      document.getElementById("Control"),
      document.getElementById("MicOn"),
      document.getElementById("RecStart"),
      document.getElementById("RecStop"),
      document.getElementById("RecMime")
    );
  });
});