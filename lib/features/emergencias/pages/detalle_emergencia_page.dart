import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/emergencia_model.dart';

class DetalleEmergenciaPage extends StatelessWidget {
  final EmergenciaModel emergencia;
  const DetalleEmergenciaPage({super.key, required this.emergencia});

  @override
  Widget build(BuildContext context) {
    Color colorEstado = Colors.red;
    String textoEstado = 'Pendiente';
    
    if (emergencia.estado == 'EN_ATENCION') {
      colorEstado = Colors.orange;
      textoEstado = 'En Atención';
    } else if (emergencia.estado == 'RESUELTO') {
      colorEstado = Colors.green;
      textoEstado = 'Resuelto';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDC3545),
        title: const Text('Detalle de la Emergencia', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(emergencia.tipo, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: colorEstado.withOpacity(0.2), borderRadius: BorderRadius.circular(20), border: Border.all(color: colorEstado)),
                  child: Text(textoEstado, style: TextStyle(color: colorEstado, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const Divider(height: 30),
            const Text('Descripción:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 5),
            Text(emergencia.descripcion, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('Ubicación exacta:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FlutterMap(
                  options: MapOptions(initialCenter: LatLng(emergencia.lat, emergencia.lng), initialZoom: 15.0),
                  children: [
                    TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', userAgentPackageName: 'com.zonasos.cartagena.app'),
                    MarkerLayer(markers: [Marker(point: LatLng(emergencia.lat, emergencia.lng), width: 40, height: 40, child: const Icon(Icons.location_on, color: Colors.red, size: 40))]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}