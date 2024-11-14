import 'package:flutter/material.dart';

class LoginTabs extends StatelessWidget {
  final bool isLogin;
  final Function(bool) onToggle;

  const LoginTabs({
    super.key,
    required this.isLogin,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              if (!isLogin) onToggle(true);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              decoration: BoxDecoration(
                color: isLogin ? Colors.white : Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
                boxShadow: isLogin
                    ? [
                        const BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ]
                    : [],
              ),
              child: Text(
                'Log in',
                style: TextStyle(
                  color: isLogin ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              if (isLogin) onToggle(false);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              decoration: BoxDecoration(
                color: isLogin ? Colors.grey[200] : Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: !isLogin
                    ? [
                        const BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ]
                    : [],
              ),
              child: Text(
                'Sign up',
                style: TextStyle(
                  color: isLogin ? Colors.grey : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
