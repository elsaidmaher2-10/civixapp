import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/VerificationInitCubit.dart';
import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/verficationinitState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Gateverificationinitpage extends StatefulWidget {
  const Gateverificationinitpage({super.key});

  @override
  State<Gateverificationinitpage> createState() => _GateverificationinitpageState();
}

class _GateverificationinitpageState extends State<Gateverificationinitpage> {
  @override
  void didChangeDependencies() {

 context.read<VerificationInitCubit>().getVerificationRequestData();
    super.didChangeDependencies();
  }
  
  Widget build(BuildContext context) {
    return BlocBuilder<VerificationInitCubit, VerificationInitState>(
      builder: (context, state){

        if (state is VerificationSuccess){

          

        }
      },
    );
  }
}
