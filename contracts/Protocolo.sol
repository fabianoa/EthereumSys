pragma solidity ^0.4.2;

contract Protocolo {

  address public autor;
  address gerenciador;
  address remetente;
  address destinatario;
  uint tipoProtocolo; //
  string  public assunto;
  string public descricao;
  uint tempoCriacao;
  uint tempoSituacao;
  int8 situacao; // 1- Aberto, 2- Aguardando Recebimento, 3 - Recebido, 4 - Cancelado

    //Constructor
  function Protocolo(address _autor, uint _tipoProtocolo, string _assunto, string _descricao){
    gerenciador = msg.sender;
    autor = _autor;
    tipoProtocolo = _tipoProtocolo;
    assunto = _assunto;
    situacao = 1;
    descricao=_descricao;
    tempoSituacao = block.timestamp;
    tempoCriacao = block.timestamp;
  }

  
 
  function enviar(address _destinatario, string _descricao) returns (bool){
    if((situacao==1 && (msg.sender==gerenciador || msg.sender==autor)) || 
       (situacao==3 && (msg.sender==gerenciador || msg.sender==destinatario))
       ){
      destinatario=_destinatario;
      situacao=2;
      tempoSituacao = block.timestamp;
      descricao=_descricao;
      return true;   
    }else{
      throw;
    }
     
  }

  function receber() returns (bool){
    if(situacao==2  && (msg.sender==gerenciador || msg.sender==destinatario)){
      situacao=3;
      tempoSituacao = block.timestamp;
      return true;
    }else{
      throw;
    }
      
  }

  function cancelar(){
    if(situacao==1 && (msg.sender==autor || msg.sender==gerenciador)){
      situacao=4;
      tempoSituacao = block.timestamp;
    }else{
      throw; 
    }
  }
  
  function cancelarB(){
      situacao=4;
      tempoSituacao = block.timestamp;
   }


  function obterSituacaoAtual() returns (int8){
      return situacao;
  }

 
}


contract ProtocoloManager {

    struct ProtocoloInfo {
      address numero;
      address remetente;
     }
     
    ProtocoloInfo[] public protocolos;
     address[] protocolosAddr;

    function criar( uint _tipoProtocolo, string _assunto,string _descricao) returns (address rprotocolo ) {
        address _newProtocoloAddress = address(new Protocolo(msg.sender,_tipoProtocolo,_assunto,_descricao));
        //protocolos[_newProtocoloAddress]=ProtocoloInfo({
        //  numero:_newProtocoloAddress,
        //  remetente:msg.sender
        //});
        protocolosAddr.push(_newProtocoloAddress);
        return _newProtocoloAddress;
    }


     function obter(uint _id) returns (Protocolo protocolo) {
       Protocolo p = Protocolo(protocolosAddr[_id]);
       return p;
    }
    
    function enviarProtocolo(address _numero, address _destinatario,string _descricao ) returns (bool){
      Protocolo p = Protocolo(_numero);
      p.enviar(_destinatario,_descricao);
      return true;
   }
  

   
}




