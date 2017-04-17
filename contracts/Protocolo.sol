pragma solidity ^0.4.2;

contract Protocolo {

  address owner;
  address remetente;
  address destinatario;
  string tipoProtocolo;
  string public assunto;
  uint public criadoEm = block.timestamp;
   
    //Constructor
  function Protocolo(address _remetente , string _tipoProtocolo, string _assunto){
    owner = msg.sender;
    remetente = _remetente;
    tipoProtocolo = _tipoProtocolo;
    assunto = _assunto;
  }

  function obterAssunto() returns (string  _assunto){
      return assunto;
  }



}


contract ProtocoloCentralFactory {

    address[] protocolos;

    function criar(address _remetente , string _tipoProtocolo, string _assunto) returns (address rprotocolo ) {
        address _newProtocolo = address(new Protocolo(_remetente,_tipoProtocolo,_assunto));
        protocolos.push(_newProtocolo);
        return _newProtocolo;
    }

    function obter(uint _id) returns (Protocolo protocolo) {
       Protocolo p = Protocolo(protocolos[_id]);
       return p;
    }
    
  

   
}




