import 'package:flutter/material.dart';

class WaveLoginPage extends StatefulWidget {
  const WaveLoginPage({super.key});

  @override
  State<WaveLoginPage> createState() => _WaveLoginPageState();
}

class _WaveLoginPageState extends State<WaveLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // keep scaffold background same as the big white center in the screenshot
      backgroundColor: Color(0xFFF7F5F7),
      body: Stack(
        children: [
          // background painter draws top/bottom shapes exactly using control points
          Positioned.fill(child: CustomPaint(painter: WaveBackgroundPainter())),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 30),

                    // Logo area (replace with your asset)
                    SizedBox(
                      height: 130,
                      child: Column(
                        children: [
                          // Replace this Container with Image.asset('assets/softnet.png')
                          FlutterLogo(size: 64),
                          SizedBox(height: 6),
                          Text(
                            'SoftNet',
                            style: TextStyle(
                              fontSize: 24,
                              color: Color(0xFF2E8A7A),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Creativity at Work',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    _PinkInputField(hint: 'Enter Username', icon: Icons.person),
                    SizedBox(height: 12),
                    _PinkInputField(
                      hint: 'Enter Password',
                      icon: Icons.lock,
                      obscure: true,
                    ),

                    SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Color(0xFF7D463C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Text('Login', style: TextStyle(fontSize: 16)),
                      ),
                    ),

                    SizedBox(height: 180),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PinkInputField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscure;
  const _PinkInputField({
    required this.hint,
    required this.icon,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF3D9D8),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: Color(0xFF3B2B23)),
          hintText: hint,
        ),
      ),
    );
  }
}

class WaveBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // top brown bar (thin)
    paint.color = Color(0xFF8B4A3F);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, 36), paint);

    // top main blue large wave (smooth, central hump like screenshot)
    Path topWave = Path();
    topWave.moveTo(0, 36);
    // left curve up to a high peak near 30% width
    topWave.cubicTo(
      size.width * 0.12,
      10,
      size.width * 0.28,
      20,
      size.width * 0.45,
      58,
    );
    // down to mid-right shallow valley
    topWave.cubicTo(
      size.width * 0.62,
      96,
      size.width * 0.8,
      56,
      size.width,
      72,
    );
    topWave.lineTo(size.width, 0);
    topWave.lineTo(0, 0);
    topWave.close();

    paint.color = Color(0xFF3E63A8);
    canvas.drawPath(topWave, paint);

    // slim mint strip under the top wave for layered look
    Path topMint = Path();
    topMint.moveTo(0, 66);
    topMint.cubicTo(
      size.width * 0.18,
      44,
      size.width * 0.32,
      58,
      size.width * 0.5,
      78,
    );
    topMint.cubicTo(
      size.width * 0.68,
      98,
      size.width * 0.82,
      82,
      size.width,
      94,
    );
    topMint.lineTo(size.width, 86);
    topMint.lineTo(0, 86);
    topMint.close();

    paint.color = Color(0xFFDFF4E9);
    canvas.drawPath(topMint, paint);

    // bottom big blue wave which rises on the right side (matching screenshot)
    Path bottomWave = Path();
    bottomWave.moveTo(0, size.height * 0.82);
    // gentle rise then big curve up to right edge
    bottomWave.cubicTo(
      size.width * 0.18,
      size.height * 0.76,
      size.width * 0.45,
      size.height * 0.70,
      size.width * 0.6,
      size.height * 0.78,
    );
    bottomWave.cubicTo(
      size.width * 0.75,
      size.height * 0.86,
      size.width * 0.9,
      size.height * 0.94,
      size.width,
      size.height * 0.88,
    );
    bottomWave.lineTo(size.width, size.height);
    bottomWave.lineTo(0, size.height);
    bottomWave.close();

    paint.color = Color(0xFF3E63A8);
    canvas.drawPath(bottomWave, paint);

    // thin mint outline above bottom wave to separate from white center
    Path bottomMint = Path();
    bottomMint.moveTo(0, size.height * 0.80);
    bottomMint.cubicTo(
      size.width * 0.18,
      size.height * 0.74,
      size.width * 0.45,
      size.height * 0.68,
      size.width * 0.6,
      size.height * 0.76,
    );
    bottomMint.cubicTo(
      size.width * 0.75,
      size.height * 0.84,
      size.width * 0.9,
      size.height * 0.92,
      size.width,
      size.height * 0.86,
    );
    bottomMint.lineTo(size.width, size.height * 0.80);
    bottomMint.lineTo(0, size.height * 0.80);
    bottomMint.close();

    paint.color = Color(0xFFDFF4E9);
    canvas.drawPath(bottomMint, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
