class Pedidos {
  int idpedidos;
  final String utc;
  final String shipper;
  final String consignee;
  final String carrier;
  final String tracking;
  final String valorcompra;
  final String detallecompra;
  final String estado;
  final String foto;
  Pedidos(
      {this.idpedidos,
      this.utc,
      this.shipper,
      this.consignee,
      this.carrier,
      this.tracking,
      this.valorcompra,
      this.detallecompra,
      this.estado,
      this.foto});
  factory Pedidos.fromJson(Map<String, dynamic> parsedJson) {
    return Pedidos(
        idpedidos: parsedJson['idpedidos'],
        utc: parsedJson['utc'],
        shipper: parsedJson['shipper'],
        consignee: parsedJson['consignee'],
        carrier: parsedJson['carrier'],
        tracking: parsedJson['tracking'],
        valorcompra: parsedJson['valorcompra'],
        detallecompra: parsedJson['detallecompra'],
        estado: parsedJson['estado'],
        foto: parsedJson['foto']);
  }
}
